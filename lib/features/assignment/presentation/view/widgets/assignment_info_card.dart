import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/assets.dart';

class AssignmentInfoCard extends StatelessWidget {
  const AssignmentInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppAssets.courses_image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
           Expanded(
            child: Text(
              "Assignment 01:",
              style: AppStyles.style20SemiBold.copyWith(color: const Color(0xFF24234D)),
            ),
          ),
          const Icon(Icons.download_outlined, color: Colors.black),
        ],
      ),
    );
  }
}