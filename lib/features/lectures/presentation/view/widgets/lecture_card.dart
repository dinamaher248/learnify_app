import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class LectureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? time;
  final String imagePath;
  final VoidCallback onTap;
  final bool isMessageCard;

  const LectureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    this.isMessageCard = false,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 60,
            height: 90,
            child: imagePath.isNotEmpty
                ? imagePath.startsWith('http')
                      ? Image.network(imagePath, fit: BoxFit.cover)
                      : Image.asset(imagePath, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
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
        trailing: isMessageCard
            ? Text(
                time ?? " ",
                style: AppStyles.style16Medium.copyWith(
                  color: Color(0xff6B6868),
                ),
              )
            : const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black,
              ),
        onTap: onTap,
      ),
    );
  }
}
