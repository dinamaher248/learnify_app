import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/assets.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         SizedBox(
      width: 22.w,
      height: 10.h,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),

        onPressed: () {},
        backgroundColor: Color(0xff5047E4),
        child: Image.asset(AppAssets.collage_image, width: 24, height: 24),

      ),
    ),
           SizedBox(height: 1.h),
          const Text(
            "Courses",
            style: TextStyle(
              color: Color(0xFF6B6868), 
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    
  }
}
