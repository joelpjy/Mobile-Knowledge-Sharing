import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/Services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/app/config.router.dart';
import 'package:mobile_knowledge_sharing_app/ui/data/Question.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();

  List<Question> get questionList => _quizService.questionList;

  Future initialise() async {}

  void questionMarkPress() async {
    await FirebaseCrashlytics.instance
        .recordError(error, null, reason: 'Aiya walaooo', fatal: true);
    await SystemNavigator.pop();
  }

  void questionSelected(int index) async {
    _quizService.currentSelectedIndex = index;
    await _navigationService.navigateTo(Routes.questionView);
  }
}
