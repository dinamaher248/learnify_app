import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';

class AboutSection extends StatelessWidget {
  final String description;

  const AboutSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About :",
            style: AppStyles.style16Medium.copyWith(color: Color(0xff24234D),
            fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppStyles.style16Medium.copyWith(color: Color(0xff24234D),
            height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
