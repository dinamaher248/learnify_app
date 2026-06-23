import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../data/models/message_model.dart';
import '../../data/repo/messages_repo.dart';
import '../view_models/chat_cubit.dart';
import 'widgets/chat_app_bar.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/message_input_area.dart';

class ChatView extends StatelessWidget {
  final String conversationId;
  final String otherUserId;

  const ChatView({
    super.key,
    required this.conversationId,
    required this.otherUserId,
  });

  @override
  Widget build(BuildContext context) {
    // ── نقرأ conversationId و otherUserId من الـ router extra ──
    final extra = GoRouterState.of(context).extra;
    final String conversationId = (extra is Map<String, dynamic>)
        ? (extra['conversationId'] ?? '')
        : '';
    final String otherUserId = (extra is Map<String, dynamic>)
        ? (extra['otherUserId'] ?? '')
        : '';

    return BlocProvider(
      create: (_) => ChatCubit(
        repo: MessagesRepo(
          dioConsumer: DioConsumer(
            dio: Dio(),
            baseUrl: Endpoints.baseMessageUrl,
          ),
        ),
        conversationId: conversationId,
        receiverId: otherUserId,
      )..loadMessages(), // نحمّل الرسائل فور فتح الشات
      child: _ChatBody(otherUserId: otherUserId),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body منفصل عشان يستخدم context.read بعد BlocProvider
// ─────────────────────────────────────────────────────────────────────────────
class _ChatBody extends StatefulWidget {
  final String otherUserId;
  const _ChatBody({required this.otherUserId});

  @override
  State<_ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<_ChatBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // نسكرول للأسفل بعد تحميل أو إرسال
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();

    try {
      await context.read<ChatCubit>().sendMessage(text);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleFilePicked(String path) async {
    try {
      await context.read<ChatCubit>().sendFile(path, isCamera: false);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ✅ إرسال صورة من الكاميرا
  Future<void> _handleImagePicked(String path) async {
    try {
      await context.read<ChatCubit>().sendFile(path, isCamera: true);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── App Bar ──
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: ChatAppBar(),
          ),

          // ── قائمة الرسائل ──
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                // نسكرول بعد تحميل أو إرسال
                if (state is ChatLoaded || state is ChatSending) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.message}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<ChatCubit>().loadMessages(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // نأخذ الرسائل من ChatLoaded أو ChatSending
                final messages = switch (state) {
                  ChatLoaded s => s.messages,
                  ChatSending s => s.messages,
                  _ => <MessageModel>[],
                };

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet\nStart the conversation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<ChatCubit>().refreshMessages(),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      // لو فيه ملف نعرضه بشكل مختلف
                      if (msg.fileUrl != null && msg.fileType != 'None') {
                        return _FileBubble(msg: msg);
                      }

                      return ChatBubble(
                        message: msg.content ?? '',
                        isMe: msg.isMine,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // ── حالة الإرسال ──
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatSending) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'sending...',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // ── حقل الكتابة ──
          MessageInputArea(
            controller: _controller,
            onSend: (_) => _handleSend(),
            onFilePicked: _handleFilePicked,
            onImagePicked: _handleImagePicked,
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bubble بسيط لعرض الملفات
// ─────────────────────────────────────────────────────────────────────────────
class _FileBubble extends StatefulWidget {
  final MessageModel msg;
  const _FileBubble({required this.msg});

  @override
  State<_FileBubble> createState() => _FileBubbleState();
}

class _FileBubbleState extends State<_FileBubble> {
  bool _isDownloading = false;
  String _resolveFileUrl(String url) {
    if (url.startsWith('http') || url.startsWith('https')) return url;
    final base = Endpoints.baseMessageUrl;
    if (url.startsWith('/')) return '$base$url';
    return '$base/$url';
  }

  Future<void> _openFile() async {
    final rawUrl = widget.msg.fileUrl;
    if (rawUrl == null) return;
    setState(() => _isDownloading = true);

    try {
      // نحمل الملف في الـ temp directory
      // نستخدم DioConsumer عشان يضيف الـ interceptors (auth, logging)
      final consumer = DioConsumer(
        dio: Dio(),
        baseUrl: Endpoints.baseMessageUrl,
      );
      final dio = consumer.dio;
      final tempDir = await _getTempDir();
      final fileName = rawUrl.split('/').last;
      final savePath = '$tempDir/$fileName';

      // نجهز قائمة محاولات: لو الـ rawUrl كامل استخدمه، وإلا جرب baseMessage ثم baseAcadimic
      final candidates = <String>[];
      if (rawUrl.startsWith('http')) {
        candidates.add(rawUrl);
      } else {
        try {
          candidates.add(
            Uri.parse(Endpoints.baseMessageUrl).resolve(rawUrl).toString(),
          );
        } catch (_) {}
        try {
          candidates.add(
            Uri.parse(Endpoints.baseAcadimicUrl).resolve(rawUrl).toString(),
          );
        } catch (_) {}
        // try encoded path
        try {
          final enc = Uri.parse(
            Endpoints.baseMessageUrl,
          ).resolve(Uri.encodeFull(rawUrl)).toString();
          if (!candidates.contains(enc)) candidates.add(enc);
        } catch (_) {}
      }

      bool downloaded = false;
      DioException? lastDioEx;
      for (final candidate in candidates) {
        try {
          await dio.download(candidate, savePath);
          downloaded = true;
          break;
        } on DioException catch (e) {
          lastDioEx = e;
          final status = e.response?.statusCode;
          // لو 404 نجرب المرشح التالي، وإلا نرمي الاستثناء
          if (status == 404) continue;
          rethrow;
        }
      }

      if (!downloaded) {
        final tried = candidates.isNotEmpty
            ? candidates.first
            : _resolveFileUrl(rawUrl);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to download file (404). Tried: $tried'),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () async {
                  final uri = Uri.tryParse(tried);
                  if (uri != null && await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (lastDioEx != null) throw lastDioEx;
        throw Exception('Failed to download file');
      }

      // نفتح الملف بأي تطبيق مناسب على الجهاز
      final result = await OpenFilex.open(savePath);

      if (result.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No application found to open this type: ${result.message}',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<String> _getTempDir() async {
    try {
      final dir = await _getTemporaryDirectory();
      return dir;
    } catch (_) {
      return '/tmp';
    }
  }

  Future<String> _getTemporaryDirectory() async {
    // path_provider
    final dir = await _pathProviderTempDir();
    return dir;
  }

  Future<String> _pathProviderTempDir() async {
    final dir = await getTemporaryDirectory();
    return dir.path;
    // return '/data/user/0/com.example.app/cache';
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = widget.msg.fileType == 'Pdf';
    final isImage =
        widget.msg.fileType == 'Image' || widget.msg.fileType == 'Camera';

    return Align(
      alignment: widget.msg.isMine
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: GestureDetector(
        onTap: _isDownloading ? null : _openFile,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.msg.isMine
                ? const Color(0xFF24234D)
                : const Color(0xFF5047E4),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: Radius.circular(widget.msg.isMine ? 15 : 0),
              bottomRight: Radius.circular(widget.msg.isMine ? 0 : 15),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isImage && widget.msg.fileUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _resolveFileUrl(widget.msg.fileUrl!),
                    width: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const SizedBox(
                        width: 200,
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isDownloading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Icon(
                        isPdf ? Icons.picture_as_pdf : Icons.attach_file,
                        color: Colors.white,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      _isDownloading
                          ? 'loading...'
                          : isPdf
                          ? 'PDF file'
                          : 'Attached file',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),

              if (widget.msg.content != null &&
                  widget.msg.content!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  widget.msg.content!,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
