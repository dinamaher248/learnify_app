import 'package:flutter/material.dart';

import '../../../../../core/utils/custom_widgets/app_bar_widget.dart';
import 'widgets/course_list_item.dart';
import 'widgets/primary_action_button.dart';

class ParentCoursesView extends StatelessWidget {
  final String? studentId;
  final String? studentName;
  const ParentCoursesView({super.key, this.studentId, this.studentName});

  // Replace with real data / BLoC state
  static final _courses = List.generate(
    4,
    (_) => const _CourseDummy(
      title: 'information system',
      instructor: 'Ehab Gamel',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBarWidget(
        title: studentName != null && studentName!.isNotEmpty
            ? '$studentName - Courses'
            : 'Courses',
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _courses.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final course = _courses[index];
          return CourseListItem(
            title: course.title,
            instructorName: course.instructor,
            trailingWidget: PrimaryActionButton(
              label: 'About Instructor',
              onPressed: () {
                // TODO: navigate to instructor details
              },
            ),
          );
        },
      ),
    );
  }
}

class _CourseDummy {
  final String title;
  final String instructor;
  const _CourseDummy({required this.title, required this.instructor});
}
