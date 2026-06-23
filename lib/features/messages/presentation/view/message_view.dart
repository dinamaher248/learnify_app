import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../../lectures/presentation/view/widgets/lecture_card.dart';
import '../../data/repo/messages_repo.dart';
import '../view_models/conversations_cubit.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConversationsCubit(
        MessagesRepo(
          dioConsumer: DioConsumer(
            dio: Dio(),
            baseUrl: Endpoints.baseMessageUrl,
          ),
        ),
      )..loadConversations(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: BlocBuilder<ConversationsCubit, ConversationsState>(
          builder: (context, state) {
            if (state is ConversationsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ConversationsError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is ConversationsLoaded) {
              final list = state.conversations;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final c = list[index];
                  return LectureCard(
                    title:
                        (c.otherUserName != null && c.otherUserName!.isNotEmpty)
                        ? c.otherUserName!
                        : 'Unknown User',
                    subtitle: '',
                    imagePath: 'assets/images/Rectangle 23870-3.png',
                    isMessageCard: true,
                    time: c.lastMessageAt.substring(11, 16),
                    onTap: () {
                      context.push(
                        AppRouter.chatPath,
                        extra: {
                          'conversationId': c.conversationId,
                          'otherUserId': c.otherUserId,
                        },
                      );
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
