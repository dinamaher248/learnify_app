import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

import '../../../../../../core/utils/color.dart';

/// Full-width primary button reused in Courses & Attendance screens.
class PrimaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryActionButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          label,
          style: AppStyles.style16Medium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}