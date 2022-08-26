class Question {
  final String label;
  final String question;
  final int answer;
  final List<String> choices;
  bool isAnswered = false;
  bool isCorrect = false;

  Question({
    required this.label,
    required this.question,
    required this.answer,
    required this.choices,
    required this.isAnswered,
    required this.isCorrect,
  });
}
