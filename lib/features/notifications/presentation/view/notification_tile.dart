import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel data;

  const NotificationTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: data.imageUrl != null
                  ? Image.network(
                      data.imageUrl!,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(AppAssets.doc_image,fit: BoxFit.cover,),
                    ),
            ),
            const SizedBox(width: 15),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr: ${data.doctorName}",
                    style: AppStyles.style20SemiBold.copyWith(
                      color: Color(0xFF24234D),
                    ),
                  ),
                  SizedBox(height: 0.5.h),

                  Text(
                    "Material : ${data.subject}",
                    style: AppStyles.style16Medium.copyWith(
                      color: Color(0xff24234D),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "Your ${data.time} lecture has been rescheduled.",
                    style: AppStyles.style14Regular.copyWith(
                      color: Color(0xff6B6868),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
