import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/app/config.logger.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:stacked/stacked.dart';

class QuizService with ReactiveServiceMixin {
  final log = getLogger('QuizService');
  final _userService = locator<UserService>();

  List<Question> questionList = [];
  final GlobalKey<AnimatedListState> questionListKey = GlobalKey();
  final ReactiveValue<String> _totalScore = ReactiveValue('0/0');
  String get totalScore => _totalScore.value;
  int? currentSelectedIndex;

  late FirebaseFirestore db;

  QuizService(){
    listenToReactiveValues([_totalScore]);
  }

  void initialise() async {
    db = FirebaseFirestore.instance;
    var event = await db.collection('quiz').get();
    questionList.clear();
    for (var doc in event.docs) {
      var data = doc.data();
      var question = Question.fromData(doc.id, _userService.ksUser!.id, data);
      questionList.add(question);
      questionListKey.currentState?.insertItem(questionList.length - 1);
    }
    _calculateScore();
  }

  void validateAnswer(int selectionOptionIndex) {
    var question = questionList[currentSelectedIndex!];

    var isCorrect = question.answer == selectionOptionIndex;
    question.isAnswered = true;
    question.isCorrect = isCorrect;
    db.collection('quiz').doc(question.id)
      ..set({
        'isAnswered': {_userService.ksUser!.id: true},
      }, SetOptions(merge: true))
      ..set({
        'isCorrect': {_userService.ksUser!.id: isCorrect},
      }, SetOptions(merge: true));
    _calculateScore();
  }

  void _calculateScore() {
    var correctCount = 0;
    questionList.forEach((question) {
      if (question.isAnswered && question.isCorrect) {
        ++correctCount;
      }
    });

    _totalScore.value = '$correctCount/${questionList.length}';
  }
}
