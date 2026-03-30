import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/assets.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    bool isActive = currentIndex == 2;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 22.w,
            height: 10.h,
            child: FloatingActionButton(
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),

              onPressed: () => onTap(2),
              backgroundColor: Color(0xff5047E4),
              child: Image.asset(
                AppAssets.collage_image,
                width: 24,
                height: 24,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Courses",
            style: TextStyle(
              color: isActive
                  ? const Color(0xff5047E4)
                  : const Color(0xff6B6868),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
