import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/Api/endpoints.dart';
import '../../../courses/data/repo/course_repo.dart';
import '../../../courses/presentation/view_models/course_cubit.dart';
import '../../../profile_student/data/repo/student_profile_repo.dart';
import '../../../profile_student/presentation/view_models/profile_student_cubit.dart';
import 'widgets/banner_slider.dart';
import '../../courses/presentation/view/build_course_section.dart';
import 'widgets/home_header.dart';
import '../../schedule/presentation/view/schedule_section.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseCubit(
            CourseRepo(
              DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl),
            ),
          )..getCourses(),
        ),

        BlocProvider(
          create: (context) => ProfileCubit(
            StudentProfileRepo(
              DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAuthUrl),
            ),
          )..getProfile(),
        ),
      ],
      child: const HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF2F2F2),
      child: Column(
        children: [
          const HomeHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  BannerSlider(),
                  const ScheduleSection(),
                  const BuildCourseSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
