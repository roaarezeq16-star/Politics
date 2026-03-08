class QuestionModel {
  final String questionText;
  final List<AnswerOption> options;

  const QuestionModel({
    required this.questionText,
    required this.options,
  });
}

class AnswerOption {
  final String text;
  final int points;

  const AnswerOption({
    required this.text,
    required this.points,
  });
}
