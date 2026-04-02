import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'widgets/detail_item.dart';

class LecturePdfView extends StatelessWidget {
  const LecturePdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBarWidget(title: "Pdf"),
      body: Column(
        children: [
          DetailItem(
            icon: Icons.picture_as_pdf_outlined,
            label: "Lecture Pdf",
            isDownloadedIcon: true,
            isChecked: false,
            onChanged: (val) {},
          ),

        ],
      ),
    );
  }
}
