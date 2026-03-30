import 'package:flutter/material.dart';
import 'package:learnify_app/features/notifications/presentation/view/notification_tile.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../../../data/models/notification_model.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBarWidget(title: "Notification"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildSectionHeader("TODAY"),
          SizedBox(height: 3.h),
          NotificationTile(
            data: NotificationModel(
              doctorName: "Ehab Gamil",
              subject: "Database",
              time: "7:00 AM",
            ),
          ),
          NotificationTile(
            data: NotificationModel(
              doctorName: "Omar Elfarouk",
              subject: "Ai",
              time: "9:00 AM",
            ),
          ),
          NotificationTile(
            data: NotificationModel(
              doctorName: "Mohamed Saeed",
              subject: "Programming",
              time: "3:00 AM",
            ),
          ),
          NotificationTile(
            data: NotificationModel(
              doctorName: "Zeyad Walid",
              subject: "Information System",
              time: "4:00 AM",
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionHeader("YESTERDAY"),
          NotificationTile(
            data: NotificationModel(
              doctorName: "Ehab Gamil",
              subject: "Database",
              time: "10:00 AM",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF5047E4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppStyles.style16MediumUppercase.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}