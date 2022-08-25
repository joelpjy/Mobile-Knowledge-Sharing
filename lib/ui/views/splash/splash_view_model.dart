import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/app/config.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future initialise() async {
    await Future.delayed(Duration(seconds: 3));
    await _navigationService.navigateTo(Routes.homeView);
  }
}
