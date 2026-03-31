import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class LectureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;

  const LectureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        title: Text(
          title,
          style: AppStyles.style20SemiBold.copyWith(color: Color(0xFF24234D)),
        ),
        subtitle: Text(
          subtitle,
          style: AppStyles.style16Medium.copyWith(color: Color(0xff24234D)),
        ),
        trailing: const Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.black,
        ),
        onTap: onTap,
      ),
    );
  }
}
