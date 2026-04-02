import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Color(0xff6B6868), thickness: 1, indent: 10.w),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff6B6868), width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                "or",
                style: AppStyles.style20SemiBold.copyWith(
                  color: Color(0xff6B6868),
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Divider(color: Color(0xff6B6868), thickness: 1, endIndent: 10.w),
        ),
      ],
    );
  }
}
