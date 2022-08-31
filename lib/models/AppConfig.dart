import 'package:flutter/foundation.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';

class AppConfig {
  static final bool usingFakeLogin = true;
  static final Map<String, Question> fakeQuestions = {
    'PETyZPZ7IOaXqCAU2y2x': Question(
        id: UniqueKey().toString(),
        label: 'Question: Mobile Team Members',
        question: 'Who isn\'t from the Mobile team?',
        answer: 1,
        choices: ['Karen', 'Jordan', 'Yulong', 'JT', 'Joel', 'Hai', 'Jonathan'],
        isAnswered: false,
        isCorrect: false),
    '[#69483]': Question(
        id: UniqueKey().toString(),
        label: 'Question: Favourite Lunch Place',
        question: 'Where does Mobile like to go for Lunch',
        answer: 4,
        choices: ['Wan Hao', 'Food Master', 'KFC', 'Wok Hey', 'Sando'],
        isAnswered: false,
        isCorrect: false),
    'qNnhXw4uza9P2nXP3gS1': Question(
        id: UniqueKey().toString(),
        label: 'Question: Predict Winning Team',
        question: 'Which team do you think is going to win the KS of the year?',
        answer: 0,
        choices: ['Mobile', 'Core', 'Devops'],
        isAnswered: false,
        isCorrect: false)
  };
}
