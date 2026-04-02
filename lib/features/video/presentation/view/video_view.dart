import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'package:sizer/sizer.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Video"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    AppAssets.lecture_video_view,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(AppAssets.video_icon, height: 30.h, width: 30.w),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Information System",
                  style: AppStyles.style16MediumUppercase.copyWith(
                    color: const Color(0xFF24234D),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC6D1FB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "5 Min Video",
                    style: AppStyles.style14MediumInter.copyWith(
                      color: const Color(0xFF5047E4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
