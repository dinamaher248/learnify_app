import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart' show AppRouter;
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../view_models/quiz_cubit.dart';
import 'widgets/review_question_item.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBarWidget(title: "Reviews"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryCard(cubit),
            const SizedBox(height: 20),
            const Divider(thickness: 1.5),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.questions.length,
              itemBuilder: (context, index) {
                final question = cubit.questions[index];
                final userSelection = cubit.selectedAnswers[index];
                return ReviewQuestionItem(
                  index: index,
                  question: question,
                  userSelectedIndex: userSelection,
                );
              },
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5047E4),
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () => context.go(AppRouter.courseDetailsPath),
              child: Text(
                "Back To Courses",
                style: AppStyles.style20SemiBold.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(QuizCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _summaryRow(
            Icons.analytics,
            "Total Score",
            "${cubit.score}%",
            Colors.green,
          ),
          const Divider(),
          _summaryRow(
            Icons.check_circle,
            "Status",
            cubit.score >= 50 ? "Passed" : "Failed",
            cubit.score >= 50 ? Colors.green : Colors.red,
          ),
          const Divider(),
          _summaryRow(Icons.timer, "Time Taken", "5m", Colors.black),
        ],
      ),
    );
  }

  Widget _summaryRow(
    IconData icon,
    String title,
    String value,
    Color valueColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF5047E4), size: 20),
        const SizedBox(width: 10),
        Text(title, style: AppStyles.style16Medium),
        const Spacer(),
        Text(value, style: AppStyles.style16Medium.copyWith(color: valueColor)),
      ],
    );
  }
}
