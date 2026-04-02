import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../attendance/presentation/view/attendance_view.dart';
import 'widgets/detail_item.dart';

class LectureDetailsView extends StatelessWidget {
  const LectureDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DetailItem(
          icon: Icons.done_all,
          label: "Attendance",
          isChecked: true,
          onChanged: (val) {},
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const AttendanceDialog(),
            );
          },
        ),
        DetailItem(
          icon: Icons.picture_as_pdf_outlined,
          label: "Lecture Pdf",
          isChecked: false,
          onChanged: (val) {},
          onTap: () {
           context.push(AppRouter.lecturePdfPath);
          },
        ),
        DetailItem(
          icon: Icons.ondemand_video,
          label: "Video",
          isChecked: false,
          onChanged: (val) {},
          onTap: () {
            context.push(AppRouter.videoPath);
          },
        ),
        DetailItem(
          icon: Icons.edit,
          label: "Assignment",
          isChecked: false,
          onChanged: (val) {},
          onTap: () {
            context.push(AppRouter.assignmentPath);
          },
        ),
        DetailItem(
          icon: Icons.question_mark,
          label: "Quiz",
          isChecked: false,
          onChanged: (val) {},
          onTap: () {
            context.push(AppRouter.quizPath);
          },
        ),
      ],
    );
  }
}
