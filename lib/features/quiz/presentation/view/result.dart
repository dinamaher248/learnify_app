import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import 'package:learnify_app/core/utils/custom_widgets/app_bar_widget.dart';
import 'package:learnify_app/features/quiz/presentation/view/review_view.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_styles.dart';
import '../view_models/quiz_cubit.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();

    return Scaffold(
      appBar: AppBarWidget(title: "Result"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Icon(
              cubit.score >= 50 ? Icons.check_circle : Icons.cancel,
              size: 60.sp,
              color: cubit.score >= 50 ? Color(0xff0FC738) : Colors.red,
            ),

            SizedBox(height: 20),

            Text(
              cubit.score >= 50 ? "Congratulations" : "Try Again",
              style: TextStyle(
                color: cubit.score >= 50 ? Color(0xff0FC738) : Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5.h),

            Text(
              "Your Score :",
              style: AppStyles.style16Medium.copyWith(color: Color(0xff6B6868)),
            ),
            SizedBox(height: 2.h),
            Text(
              "${cubit.score}%",
              style: AppStyles.style20SemiBold.copyWith(
                color: cubit.score >= 50 ? Color(0xff0FC738) : Colors.red,
              ),
            ),

            SizedBox(height: 40),
            Button(
              onBackTap: () {
                context.go(AppRouter.courseDetailsPath);
              },
              onTap: () {
                final quizCubit = BlocProvider.of<QuizCubit>(
                  context,
                  listen: false,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: quizCubit,
                      child: const ReviewView(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.onTap, this.onBackTap});

  final VoidCallback onTap;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: onBackTap,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Back to Courses",
                        style: AppStyles.style20SemiBold.copyWith(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 3.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5047E4),
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: onTap,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reviews",
                        style: AppStyles.style20SemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
