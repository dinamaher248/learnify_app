enum QuestionType { mcq, essay }

class QuestionModel {
  final String question;
  final List<String>? answers;
  final int? correctIndex;
  final QuestionType type;

  QuestionModel({
    required this.question,
    this.answers,
    this.correctIndex,
    required this.type,
  });
}