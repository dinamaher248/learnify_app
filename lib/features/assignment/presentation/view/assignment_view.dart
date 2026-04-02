import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/app_styles.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'package:learnify_app/features/assignment/presentation/view/widgets/or_divider.dart';
import 'package:learnify_app/features/assignment/presentation/view/widgets/upload_area.dart';
import 'package:sizer/sizer.dart';

import 'widgets/assignment_info_card.dart';
import 'widgets/assignment_url_Field.dart';

class AssignmentView extends StatelessWidget {
  const AssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBarWidget(title: "Assignment"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AssignmentInfoCard(),
            const SizedBox(height: 30),
            const UploadArea(),
             SizedBox(height: 5.h),
            OrDivider(),
             SizedBox(height: 7.h),
             Text("Share Project URL :",style: AppStyles.style16Medium.copyWith(color: Color(0xff6B6868)),),
            const SizedBox(height: 20),
            const AssignmentUrlField(),
          ],
        ),
      ),
    );
  }
}
