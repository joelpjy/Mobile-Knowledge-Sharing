class Question {
  final String id;
  final String label;
  final String question;
  final int answer;
  final List<String> choices;
  bool isAnswered = false;
  bool isCorrect = false;

  Question({
    required this.id,
    required this.label,
    required this.question,
    required this.answer,
    required this.choices,
    required this.isAnswered,
    required this.isCorrect,
  });

  factory Question.fromData(String id, String uid, Map<String, dynamic> data) {
    return Question(
      id: id,
      label: data['label'],
      question: data['question'],
      answer: data['answer'],
      choices: List<String>.from(data['choices']),
      isAnswered: data['isAnswered'] ?? false,
      isCorrect: data['isCorrect'] ?? false,
    );
  }
}
