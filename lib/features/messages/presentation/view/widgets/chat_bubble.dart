import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF24234D) : const Color(0xFF5047E4),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: AppStyles.style16Medium.copyWith(color: Colors.white),
            ),
            if (isMe) ...[
              const SizedBox(width: 5),
              const Icon(Icons.done_all, size: 16, color: Colors.white70),
            ],
          ],
        ),
      ),
    );
  }
}
