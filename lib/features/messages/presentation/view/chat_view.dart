import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:sizer/sizer.dart';

import 'widgets/chat_app_bar.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/message_input_area.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.push(AppRouter.profilePath);
            },
            child: ChatAppBar(),
          ),
          Expanded(
            child: ListView(
              children: const [
                ChatBubble(message: "hello", isMe: false),
                ChatBubble(message: "hello , saeed", isMe: true),
              ],
            ),
          ),
          MessageInputArea(),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}
