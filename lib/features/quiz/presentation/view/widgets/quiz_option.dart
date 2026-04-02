import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';
class QuizOption extends StatelessWidget {
  final String label;
  final void Function() ontap;
  final bool isSelected;

  const QuizOption({
    super.key,
    required this.label,
    required this.ontap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: ListTile(
        onTap: ontap,
        leading: CircleAvatar(
          radius: 12,
          backgroundColor:
              isSelected ? Colors.green : Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xff6B6868), width: 1),
            ),
          ),
        ),
        title: Text(label, style: AppStyles.style16Medium),
      ),
    );
  }
}