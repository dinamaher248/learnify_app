import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify_app/features/quiz/presentation/view_models/quiz_state.dart';

import '../../data/models/question_model.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizState(currentIndex: 0, selectedIndex: -1)) {
    selectedAnswers = List.filled(questions.length, null);
  }
  List<QuestionModel> questions = [
    QuestionModel(
      question: "What is UI?",
      answers: [
        "User Interface",
        "User Experience",
        "Computer Hardware",
        "Network Security",
      ],
      correctIndex: 0,
      type: QuestionType.mcq,
    ),

    QuestionModel(
      question: "What is Ux? -User Interface ",
      answers: ["true", "false"],
      correctIndex: 1,
      type: QuestionType.mcq,
    ),

    QuestionModel(question: "What is UI/UX?", type: QuestionType.essay),
  ];
  List<int?> selectedAnswers = [];

  String essayAnswer = "";

  void selectAnswer(int index) {
    selectedAnswers[state.currentIndex] = index;

    emit(state.copyWith(selectedIndex: index));
  }

  void updateEssay(String value) {
    essayAnswer = value;
  }

  void nextQuestion() {
    if (state.currentIndex < questions.length - 1) {
      final nextIndex = state.currentIndex + 1;

      emit(
        QuizState(
          currentIndex: nextIndex,
          selectedIndex: selectedAnswers[nextIndex] ?? -1,
        ),
      );
    }
  }

  void previousQuestion() {
    if (state.currentIndex > 0) {
      final prevIndex = state.currentIndex - 1;

      emit(
        QuizState(
          currentIndex: prevIndex,
          selectedIndex: selectedAnswers[prevIndex] ?? -1,
        ),
      );
    }
  }

  int get score {
    int correct = 0;
    int totalMcq = 0;

    for (int i = 0; i < questions.length; i++) {
      if (questions[i].type == QuestionType.mcq) {
        totalMcq++;

        if (selectedAnswers[i] == questions[i].correctIndex) {
          correct++;
        }
      }
    }

    return ((correct / totalMcq) * 100).toInt();
  }
}
