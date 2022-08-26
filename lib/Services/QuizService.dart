import 'package:mobile_knowledge_sharing_app/ui/data/Question.dart';

class QuizService {
  final List<Question> questionList = [
    Question(
        label: 'Question 1',
        question: 'Who is not part of the mobile team?',
        answer: 6,
        choices: [
          'Yu Long',
          'Karen',
          'JT',
          'Jonathan',
          'Joel',
          'hai',
          'Chris',
        ],
        isAnswered: false,
        isCorrect: false),
    Question(
        label: 'Question 2',
        question: "h",
        answer: 0,
        choices: [""],
        isAnswered: false,
        isCorrect: false),
    Question(
        label: 'Question 3',
        question: "h",
        answer: 0,
        choices: [""],
        isAnswered: false,
        isCorrect: false),
    Question(
        label: 'Question 4',
        question: "h",
        answer: 0,
        choices: [""],
        isAnswered: false,
        isCorrect: false),
  ];

  int? currentSelectedIndex;

  void validateAnswer(int selectionOptionIndex) {
    questionList[currentSelectedIndex!].isAnswered = true;
    questionList[currentSelectedIndex!].isCorrect =
        (questionList[currentSelectedIndex!].answer == selectionOptionIndex);
  }
}
