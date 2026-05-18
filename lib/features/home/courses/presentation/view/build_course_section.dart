import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/row_show.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/custom_widgets/course_card.dart';
import '../../../../courses/presentation/view_models/course_cubit.dart';
import '../../../../courses/presentation/view_models/course_state.dart';

class BuildCourseSection extends StatelessWidget {
  const BuildCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CourseCard(
              id: "Loading...",
              title: "Loading...",
              instructorName: "Loading...",
              progress: 0,
              imageUrl: AppAssets.courses_image,
              instructorAvatar: AppAssets.profile,
            ),
          );
        }

        if (state is CourseFailure) {
          return Center(child: Text(state.message));
        }

        if (state is CourseSuccess) {
          final courses = state.courses.take(2).toList();

          return Column(
            children: [
              RowShow(
                title: "Courses :",
                subTitle: "Show All",
                onPressed: () {
                  context.push(AppRouter.courseDetailsPath);
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.h,
                  horizontal: 4.0.w,
                ),
                child: Row(
                  children: List.generate(courses.length, (index) {
                    final course = courses[index];

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 0 ? 2.w : 0),
                        child: CourseCard(
                          id: course.id,
                          title: course.name,
                          instructorName: course.instructorName,
                          progress: course.completionPercentage / 100,
                          imageUrl:
                              course.coverImageUrl ?? AppAssets.courses_image,
                          instructorAvatar: course.instructorImage,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
