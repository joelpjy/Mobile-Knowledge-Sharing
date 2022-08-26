import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();

  Future initialise() async {
    await _userService.initialise();
    if (_userService.isLogin){
      await _navigationService.replaceWith(Routes.homeView);
      return;
    }
    await Future.delayed(Duration(seconds: 3));
  }


  void facebookLogin() async {
    setBusy(true);
    await _navigationService.replaceWith(Routes.homeView);
    setBusy(false);
  }

  void signInWithGoogle() async {
    setBusy(true);
    try {
      var isLogin = await _userService.googleSignIn();
      if (isLogin) {
        await _navigationService.replaceWithTransition(HomeView(),
            duration: Duration(milliseconds: 1000),
            transitionStyle: Transition.fade);
      } else {
        _snackbarService.showSnackbar(message: 'Login unsuccessful');
      }
    } on PlatformException catch (e) {
      var message = e.message;
      if (message != null) {
        _snackbarService.showSnackbar(message: message);
      }
    }
    setBusy(false);
  }
}
