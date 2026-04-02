import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/quiz/presentation/view/result.dart';
import 'package:learnify_app/features/quiz/presentation/view/widgets/quiz_option.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/custom_widgets/app_bar_widget.dart';
import '../../data/models/question_model.dart';
import '../view_models/quiz_cubit.dart';
import '../view_models/quiz_state.dart';
import 'widgets/essay_quiz_view.dart';
import 'widgets/next_button.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(),
      child: Scaffold(
        appBar: AppBarWidget(title: "Quiz"),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            final cubit = context.read<QuizCubit>();
            final question = cubit.questions[state.currentIndex];

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${state.currentIndex + 1}",
                          style: AppStyles.style20SemiBold.copyWith(
                            color: Color(0xFF5047E4),
                          ),
                        ),
                        SizedBox(height: 2.h),

                        Text(
                          question.question,
                          style: AppStyles.style20SemiBold,
                        ),

                        SizedBox(height: 20),

                        if (question.type == QuestionType.mcq)
                          ...List.generate(
                            question.answers!.length,
                            (index) => QuizOption(
                              label: question.answers![index],
                              isSelected: state.selectedIndex == index,
                              ontap: () {
                                context.read<QuizCubit>().selectAnswer(index);
                              },
                            ),
                          )
                        else
                          EssayQuestionView(
                            onChanged: (value) {
                              context.read<QuizCubit>().updateEssay(value);
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                NextButton(
                  isBackEnabled: state.currentIndex > 0,
                  onTap: () {
                    final question = cubit.questions[state.currentIndex];

                    if (question.type == QuestionType.mcq &&
                        state.selectedIndex == -1)
                      return;

                    if (state.currentIndex == cubit.questions.length - 1) {
                      final cubitInstance = context
                          .read<QuizCubit>(); 

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubitInstance,
                            child: const ResultView(),
                          ),
                        ),
                      );
                    } else {
                      cubit.nextQuestion();
                    }
                  },
                  onBackTap: () {
                    cubit.previousQuestion();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
