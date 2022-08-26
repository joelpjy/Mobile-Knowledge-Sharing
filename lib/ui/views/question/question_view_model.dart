import 'package:mobile_knowledge_sharing_app/Services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/ui/data/Question.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();

  bool? finalIsRight;
  List<Question> get questionList => _quizService.questionList;
  Question get currentQuestion =>
      questionList[_quizService.currentSelectedIndex!];
  List<String> get choiceList => currentQuestion.choices;
  String get titleLabel => currentQuestion.label;
  String get question => currentQuestion.question;

  Future initialise() async {}

  void selectChoice(int index) async {
    _quizService.validateAnswer(index);

    if (currentQuestion.isCorrect) {
      print("OK GOOD");
      finalIsRight = true;
    } else {
      print("NOT GOOD");
      finalIsRight = false;
    }

    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _navigationService.back();
  }
}
