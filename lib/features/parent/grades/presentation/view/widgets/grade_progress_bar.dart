import 'package:flutter/material.dart';

import '../../../../../../core/utils/color.dart';

/// Inline progress bar + percentage label for the Grades screen.
class GradeProgressBar extends StatelessWidget {
  /// Value between 0.0 and 1.0.
  final double progress;

  const GradeProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE0E0E0),
            color: AppColors.primaryColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "${(progress * 100).toInt()}%",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}