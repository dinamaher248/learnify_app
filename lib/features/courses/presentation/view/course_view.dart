import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/custom_widgets/course_card.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
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
        itemCount: 20,
        itemBuilder: (context, index) {
          return CourseCard(
            title: "information system",
            instructorName: "Ehab Gamel",
            progress: 0.45,
            imageUrl: AppAssets.courses_image,
            instructorAvatar: AppAssets.doc_profile,
          );
        },
      ),
    );
  }
}
