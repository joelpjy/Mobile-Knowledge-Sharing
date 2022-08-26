import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/app/config.logger.dart';
import 'package:mobile_knowledge_sharing_app/services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/models/Question.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionViewModel extends BaseViewModel {
  final log = getLogger('QuestionViewModel');
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();

  bool? finalIsRight;
  List<Question> get questionList => _quizService.questionList;
  Question get currentQuestion =>
      questionList[_quizService.currentSelectedIndex!];
  List<String> get _choiceList => currentQuestion.choices;
  String get titleLabel => currentQuestion.label;
  String get question => currentQuestion.question;

  List<String> finalChoiceList = [];

  final GlobalKey<AnimatedListState> optionListKey = GlobalKey();

  Future initialise() async {
    var future = Future(() {});
    for (var i = 0; i < _choiceList.length; i++) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 75), () {
          finalChoiceList.add(_choiceList[i]);
          optionListKey.currentState?.insertItem(finalChoiceList.length - 1);
        });
      });
    }
  }

  void selectChoice(int index) async {
    _quizService.validateAnswer(index);

    if (currentQuestion.isCorrect) {
      log.d('OK GOOD');
      finalIsRight = true;
    } else {
      log.d('NOT GOOD');
      finalIsRight = false;
    }

    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _navigationService.back();
  }
}
