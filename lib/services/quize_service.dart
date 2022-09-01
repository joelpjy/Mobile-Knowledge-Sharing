import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/app/config.logger.dart';
import 'package:mobile_knowledge_sharing_app/mobilesdk.dart';
import 'package:mobile_knowledge_sharing_app/models/AppConfig.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:mobile_knowledge_sharing_app/utils/firebase_crashlytics_utils.dart';
import 'package:stacked/stacked.dart';

class MobileMostDefinitelyMustWinException implements Exception {}

class QuizService with ReactiveServiceMixin {
  final log = getLogger('QuizService');
  final _userService = locator<UserService>();

  final ReactiveValue<List<Question>> _questionList = ReactiveValue([]);

  List<Question> get questionList => _questionList.value;
  GlobalKey<AnimatedListState> questionListKey = GlobalKey();
  final ReactiveValue<String> _totalScore = ReactiveValue('0/0');

  String get totalScore => _totalScore.value;
  int? currentSelectedIndex;

  late FirebaseFirestore db;

  QuizService() {
    listenToReactiveValues([_totalScore, _questionList]);
  }

  Future<void> initialise() async {
    FirebaseCrashlyticsUtils.log('QuizService', 'initialise', 'called');
    db = FirebaseFirestore.instance;
    var event = await db.collection('quiz').get();
    questionListKey = GlobalKey();
    _questionList.value.clear();
    for (var doc in event.docs) {
      var data = doc.data();
      if (AppConfig.usingFakeLogin) {
        debugPrint(doc.id);
        /**
         * flutter: PETyZPZ7IOaXqCAU2y2x
            flutter: [#69483]
            flutter: qNnhXw4uza9P2nXP3gS1
         */
        FirebaseCrashlyticsUtils.log(
            'QuizService', 'initialise', 'loading questions');
        var question = AppConfig.fakeQuestions[doc.id];
        if (question != null) _questionList.value.add(question);
      } else {
        var question = Question.fromData(doc.id, _userService.ksUser!.id, data);
        _questionList.value.add(question);
      }
      questionListKey.currentState?.insertItem(questionList.length - 1);
    }
    _calculateScore();
  }

  void validateAnswer(int selectionOptionIndex) async {
    var question = questionList[currentSelectedIndex!];

    var isCorrect = question.answer == selectionOptionIndex;

    FirebaseCrashlyticsUtils.log('QuizService', 'validateAnswer',
        'validating $selectionOptionIndex, labelled[${question.label}], correct? $isCorrect');

    if (question.label == questionList.last.label) {
      // reality not accepted
      await MobileSdk.validateAnswer(isCorrect);
    }

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
