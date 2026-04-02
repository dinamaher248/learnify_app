import 'package:flutter/material.dart';

class EssayQuestionView extends StatelessWidget {
  final Function(String) onChanged;

  const EssayQuestionView({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 6,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Write...",
        filled: true,
        fillColor: const Color(0xFFC6D1FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}