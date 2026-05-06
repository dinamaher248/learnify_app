import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../../courses/data/repo/course_repo.dart';
import '../../../courses/presentation/view_models/course_cubit.dart';
import 'widgets/banner_slider.dart';
import '../../courses/presentation/view/build_course_section.dart';
import 'widgets/home_header.dart';
import '../../schedule/presentation/view/schedule_section.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(
        CourseRepo(
          DioConsumer(
            dio: Dio(),
            baseUrl: Endpoints.baseAcadimicUrl,
          ),
        ),
      )..getCourses(),

      child: Container(
        color: const Color(0xffF2F2F2),
        child: Column(
          children: [
            HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
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
      ),
    );
  }
 }