import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/core/Api/endpoints.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/Api/dio_consumer.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/custom_widgets/course_card.dart';
import '../../data/repo/course_repo.dart';
import '../view_models/course_cubit.dart';
import '../view_models/course_state.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(
        CourseRepo(DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAcadimicUrl)),
      )..getCourses(),
      child: const CourseViewBody(),
    );
  }
}

class CourseViewBody extends StatelessWidget {
  const CourseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 0.140.w,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CourseCard(
                  title: "Loading...",
                  instructorName: "Loading...",
                  id: "Loading...",
                  progress: 0,
                  imageUrl: AppAssets.courses_image,
                  instructorAvatar: AppAssets.profile,
                ),
              );
            },
          );
        }
        if (state is CourseFailure) {
          return Center(child: Text(state.message));
        }

        if (state is CourseSuccess) {
          return SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 0.140.w,
              ),

              itemCount: state.courses.length,

              itemBuilder: (context, index) {
                final course = state.courses[index];

                return CourseCard(
                  id: course.id,
                  title: course.name,
                  instructorName: course.instructorName,
                  progress: course.completionPercentage / 100,
                  imageUrl: course.coverImageUrl ?? AppAssets.courses_image,
                  instructorAvatar: course.instructorImage,
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
