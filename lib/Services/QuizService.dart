import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/ui/data/Question.dart';

class QuizService {
  final List<Question> _finalQuestionList = [
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

  List<Question> questionList = [];
  final GlobalKey<AnimatedListState> questionListKey = GlobalKey();
  int? currentSelectedIndex;

  void initialise() async {
    var future = Future(() {});
    for (var i = 0; i < _finalQuestionList.length; i++) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 75), () {
          questionList.add(_finalQuestionList[i]);
          questionListKey.currentState?.insertItem(questionList.length - 1);
        });
      });
    }
  }

  void validateAnswer(int selectionOptionIndex) {
    questionList[currentSelectedIndex!].isAnswered = true;
    questionList[currentSelectedIndex!].isCorrect =
        (questionList[currentSelectedIndex!].answer == selectionOptionIndex);
  }

  String getCurrentScore() {
    var correctCount = 0;
    questionList.forEach((question) {
      if (question.isAnswered && question.isCorrect) {
        ++correctCount;
      }
    });

    return '$correctCount/${questionList.length}';
  }
}
