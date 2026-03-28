import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_styles.dart';

class RowShow extends StatelessWidget {
  RowShow({super.key, required this.title, required this.subTitle});
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.style20SemiBold.copyWith(color: Color(0xff24234D)),
        ),
        SizedBox(width: 46.w),
        Container(
          height: 4.2.h,
          decoration: BoxDecoration(
            color: Color(0xFFC6D1FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              subTitle,
              style: AppStyles.style14MediumInter.copyWith(
                color: Color(0xFF24234D),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
