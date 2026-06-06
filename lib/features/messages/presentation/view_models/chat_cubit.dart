import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_model.dart';
import '../../data/repo/messages_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final MessagesRepo repo;
  final String conversationId;
  final String receiverId; // = otherUserId

  List<MessageModel> _messages = [];

  ChatCubit({
    required this.repo,
    required this.conversationId,
    required this.receiverId,
  }) : super(ChatInitial());

  // ──────────────────────────────────────────────
  // تحميل الرسائل من API
  // ──────────────────────────────────────────────
  Future<void> loadMessages() async {
     if (conversationId.trim().isEmpty) {
      emit(ChatError('conversationId فاضي — تأكد إن الـ extra بيتبعت من MessageView'));
      return;
    }
    emit(ChatLoading());
    try {
      final raw = await repo.getConversationMessages(
        conversationId: conversationId,
      );

      // الـ API بيرجع أحدث رسالة أول، فـ نعكسهم عشان الـ ListView يكون صح
      _messages = raw
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();

      emit(ChatLoaded(List.from(_messages)));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  // ──────────────────────────────────────────────
  // إرسال رسالة نصية
  // ──────────────────────────────────────────────
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
     if (receiverId.trim().isEmpty) {
      throw Exception('receiverId فاضي — تأكد من تمرير otherUserId في الـ extra');
    }

    // Optimistic update — نضيف الرسالة فوراً في الـ UI
    final optimisticMsg = MessageModel(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      senderId: '',          // مش محتاجين sender id هنا للعرض
      isMine: true,
      content: content.trim(),
      fileType: 'None',
      isRead: false,
      sentAt: DateTime.now().toIso8601String(),
    );

    _messages.add(optimisticMsg);
    emit(ChatSending(List.from(_messages)));

    try {
      await repo.sendMessage(receiverId: receiverId, content: content.trim());

      // بعد الإرسال نعمل refresh للرسائل من الـ API
      await _refreshMessages();
    } catch (e) {
      // لو فشل نشيل الرسالة الـ optimistic ونرجع error
      _messages.remove(optimisticMsg);
      emit(ChatLoaded(List.from(_messages)));

      // نرفع exception للـ view يعرض snackbar
      rethrow;
    }
  }

  // ──────────────────────────────────────────────
  // إرسال ملف 
  // ─────────────────────────────────────────────
  Future<void> sendFile(String filePath, {bool isCamera = false}) async {
    if (conversationId.trim().isEmpty) throw Exception('conversationId فاضي');
 
    // Optimistic bubble للملف
    final optimisticMsg = MessageModel(
      id: 'temp_file_${DateTime.now().millisecondsSinceEpoch}',
      senderId: '',
      isMine: true,
      content: isCamera ? 'صورة' : 'ملف',
      fileType: isCamera ? 'Camera' : 'Pdf',
      isRead: false,
      sentAt: DateTime.now().toIso8601String(),
    );
 
    _messages.add(optimisticMsg);
    emit(ChatSending(List.from(_messages)));
 
    try {
      await repo.sendFile(
        conversationId: conversationId,
        filePath: filePath,
        content: '',
        isCamera: isCamera,
      );
      await _refreshMessages();
    } catch (e) {
      _messages.remove(optimisticMsg);
      emit(ChatLoaded(List.from(_messages)));
      rethrow;
    }
  }
  // ──────────────────────────────────────────────
  // refresh بدون loading indicator (للـ pull-to-refresh)
  // ──────────────────────────────────────────────
  Future<void> refreshMessages() async {
    await _refreshMessages();
  }

  Future<void> _refreshMessages() async {
    try {
      final raw = await repo.getConversationMessages(
        conversationId: conversationId,
      );

      _messages = raw
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();

      emit(ChatLoaded(List.from(_messages)));
    } catch (_) {
      // لو فشل الـ refresh نفضل على الحالة الحالية
      emit(ChatLoaded(List.from(_messages)));
    }
  }
}