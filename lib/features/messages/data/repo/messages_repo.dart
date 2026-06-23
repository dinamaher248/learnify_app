import 'package:dio/dio.dart' show FormData, MultipartFile, Options;

import '../../../../../core/Api/dio_consumer.dart';
import '../models/conversation_model.dart';

class MessagesRepo {
  final DioConsumer dioConsumer;

  MessagesRepo({required this.dioConsumer});

  Future<List<ConversationModel>> getConversations({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    final data = await dioConsumer.get(
      '/api/v1/messages/conversations',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );

    final list = (data['data'] as List)
        .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<Map<String, dynamic>> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    final body = {'receiverId': receiverId, 'content': content};
    final data = await dioConsumer.post('/api/v1/messages/send', data: body);
    return data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getConversationMessages({
    required String conversationId,
    int pageNumber = 1,
    int pageSize = 30,
  }) async {
    // ✅ Guard: لو conversationId فاضي ارجع list فاضية بدل ما تكسر الـ URL
    if (conversationId.trim().isEmpty) {
      throw Exception('conversationId is empty — check router extra');
    }

    // ✅ URL صح: /api/v1/messages/conversations/{conversationId}
    final data = await dioConsumer.get(
      '/api/v1/messages/conversations/$conversationId',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );

    return data['data'] as List;
  }

   Future<Map<String, dynamic>> sendFile({
    required String conversationId,
    required String filePath,
    String? content,
    bool isCamera = false,
  }) async {
    final fileName = filePath.split(RegExp(r'[\\/]')).last;
 
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'content': content ?? '',
      'isCamera': isCamera,
    });
 
    final data = await dioConsumer.post(
      '/api/v1/messages/conversations/$conversationId/send-file',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return data as Map<String, dynamic>;
  }
}