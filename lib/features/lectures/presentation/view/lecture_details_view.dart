import 'package:flutter/material.dart';
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
        ),
        DetailItem(
          icon: Icons.picture_as_pdf_outlined,
          label: "Lecture Pdf",
          isChecked: false,
          onChanged: (val) {},
        ),
        DetailItem(
          icon: Icons.ondemand_video,
          label: "Video",
          isChecked: false,
          onChanged: (val) {},
        ),
        DetailItem(
          icon: Icons.edit,
          label: "Assignment",
          isChecked: false,
          onChanged: (val) {},
        ),
        DetailItem(
          icon: Icons.question_mark,
          label: "Quiz",
          isChecked: false,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
