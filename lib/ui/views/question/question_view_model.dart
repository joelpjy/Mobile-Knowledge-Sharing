import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/Services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/ui/data/Question.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();

  List<Question> get questionList => _quizService.questionList;
  String get titleLabel =>
      questionList[_quizService.currentSelectedIndex!].label;
  String get question =>
      questionList[_quizService.currentSelectedIndex!].question;

  Future initialise() async {}

  void questionMarkPress() async {
    await FirebaseCrashlytics.instance
        .recordError(error, null, reason: 'Aiya walaooo', fatal: true);
    await SystemNavigator.pop();
  }
}
