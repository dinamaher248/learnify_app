
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';

class UploadArea extends StatelessWidget {
  const UploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: const RectDottedBorderOptions(
        dashPattern: [6, 3],
        strokeCap: StrokeCap.round,
       
        color: Colors.grey,
        strokeWidth: 1,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(Icons.upload, size: 8.w),
            SizedBox(height: 1.h),
            const Text("Upload Files", style: AppStyles.style20SemiBold),
            SizedBox(height: 3.h),
            Directionality(
              textDirection: TextDirection.rtl, //right to left
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5047E4),
                  fixedSize: Size(40.w, 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                label: Text(
                  "Upload",
                  style: AppStyles.style20SemiBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
