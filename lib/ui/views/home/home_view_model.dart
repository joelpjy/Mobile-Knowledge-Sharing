import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/app/config.router.dart';
import 'package:mobile_knowledge_sharing_app/mobilesdk.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';
import 'package:mobile_knowledge_sharing_app/models/user.dart';
import 'package:mobile_knowledge_sharing_app/services/quize_service.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/question/question_view.dart';
import 'package:mobile_knowledge_sharing_app/utils/firebase_crashlytics_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();
  final _userService = locator<UserService>();

  GlobalKey<AnimatedListState> get questionListKey =>
      _quizService.questionListKey;
  List<Question> get questionList => _quizService.questionList;
  String get totalScore => _quizService.totalScore;

  KsUser? get user => _userService.ksUser;
  String get username => user?.name ?? '';
  String get userEmail => user?.email ?? '';
  String? get userDisplayPhoto => user?.display;

  Future initialise() async {
    FirebaseCrashlyticsUtils.log('HomeViewModel', 'initialise', 'called');
    await _quizService.initialise();
  }

  void questionMarkPress() async {
    await MobileSdk.trigger();
    exit(0);
  }

  void questionSelected(int index) async {
    FirebaseCrashlyticsUtils.log(
        'HomeViewModel', 'questionSelected', 'selecting: $index');
    _quizService.currentSelectedIndex = index;

    if (_quizService.questionList[index].isEnabled &&
        !_quizService.questionList[index].isAnswered) {
      await _navigationService.navigateWithTransition(QuestionView(),
          opaque: true,
          duration: Duration(milliseconds: 200),
          transitionStyle: Transition.fade);
    }
    notifyListeners();
  }

  void logout() async {
    FirebaseCrashlyticsUtils.log('HomeViewModel', 'logout', 'logging out');
    await _userService.logout();
    await _navigationService.replaceWith(Routes.splashView);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_quizService];
}
