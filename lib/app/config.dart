import 'package:mobile_knowledge_sharing_app/services/QuizService.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/login/login_view.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/question/question_view.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: QuestionView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: QuizService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: UserService),
  ],
  logger: StackedLogger(),
)
class Config {}
