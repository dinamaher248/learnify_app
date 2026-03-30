import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/row_show.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/custom_widgets/course_card.dart';

class BuildCourseSection extends StatelessWidget {
  const BuildCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowShow(
          title: "Courses :",
          subTitle: "Show All",
          onPressed: () {
            context.go(AppRouter.courseDetailsPath);
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 4.0.w),
          child: Row(
            children: [
              CourseCard(
                title: "information system",
                instructorName: "Ehab Gamel",
                progress: 0.45,
                imageUrl: AppAssets.courses_image,
                instructorAvatar: AppAssets.doc_profile,
              ),
              const SizedBox(width: 16),
              CourseCard(
                title: "information system",
                instructorName: "Ehab Gamel",
                progress: 0.45,
                imageUrl: AppAssets.courses_image,
                instructorAvatar: AppAssets.doc_profile,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
