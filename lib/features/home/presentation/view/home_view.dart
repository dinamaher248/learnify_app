import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'widgets/banner_slider.dart';
import 'widgets/build_course_section.dart';
import 'widgets/home_header.dart';
import 'widgets/schedule_section.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F2F2),
      child: Column(
        
        children: [
          HomeHeader(),
      
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  BannerSlider(),
                  ScheduleSection(),
                  BuildCourseSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
