import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/question_model.dart';

class ReviewQuestionItem extends StatelessWidget {
  final int index;
  final QuestionModel question;
  final int? userSelectedIndex;

  const ReviewQuestionItem({
    super.key,
    required this.index,
    required this.question,
    required this.userSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Question ${index + 1}", style: AppStyles.style16Medium.copyWith(color: const Color(0xFF5047E4))),
            const Text("10 Points", style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 10),
        Text(question.question, style: AppStyles.style16Medium),
        const SizedBox(height: 15),
        
        if (question.type == QuestionType.mcq)
          ...List.generate(question.answers!.length, (i) {
            bool isCorrect = i == question.correctIndex;
            bool isSelected = i == userSelectedIndex;
            
            // تحديد اللون
            Color bgColor = Colors.white;
            if (isCorrect) bgColor = Colors.green.withOpacity(0.4); // الإجابة الصح دايما اخضر
            if (isSelected && !isCorrect) bgColor = Colors.red.withOpacity(0.4); // لو اختار غلط يظهر احمر

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected || isCorrect ? Icons.check_circle : Icons.circle_outlined,
                    size: 20,
                    color: isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  Text(question.answers![i], style: AppStyles.style16Medium),
                ],
              ),
            );
          })
        else
          // في حالة الـ Essay
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text("Writer...", style: TextStyle(fontStyle: FontStyle.italic)),
          ),
      ],
    );
  }
}