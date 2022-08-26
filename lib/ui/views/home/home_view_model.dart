import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';
import 'package:mobile_knowledge_sharing_app/services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/question/question_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();

  GlobalKey<AnimatedListState> get questionListKey =>
      _quizService.questionListKey;
  List<Question> get questionList => _quizService.questionList;
  String get totalScore => _quizService.getCurrentScore();

  Future initialise() async {
    _quizService.initialise();
  }

  void questionMarkPress() async {
    await FirebaseCrashlytics.instance
        .recordError(error, null, reason: 'Aiya walaooo', fatal: true);
    await SystemNavigator.pop();
  }

  void questionSelected(int index) async {
    _quizService.currentSelectedIndex = index;
    //if (!_quizService.questionList[index].isAnswered) {
    await _navigationService.navigateWithTransition(QuestionView(),
        opaque: true,
        duration: Duration(milliseconds: 200),
        transitionStyle: Transition.fade);
    //}
    notifyListeners();
  }
}
