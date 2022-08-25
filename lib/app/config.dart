import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
  logger: StackedLogger(),
)
class Config {}
