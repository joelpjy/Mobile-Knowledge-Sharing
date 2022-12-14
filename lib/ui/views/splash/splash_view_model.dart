import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/models/user.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';
import 'package:mobile_knowledge_sharing_app/utils/firebase_crashlytics_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();

  bool get isLogin => _userService.isLogin;

  Future initialise() async {
    FirebaseCrashlyticsUtils.log('SplashViewModel', 'initialise', 'called');
    await _userService.initialise();
    notifyListeners();
    if (_userService.isLogin) {
      await Future.delayed(Duration(seconds: 2));
      await _navigationService.replaceWithTransition(HomeView(),
          duration: Duration(milliseconds: 1000),
          transitionStyle: Transition.fade);
      return;
    }
    setInitialised(true);
  }

  String _userName = '';

  void fakeLogin() async {
    FirebaseCrashlyticsUtils.log('SplashViewModel', 'fakeLogin', 'logging in');
    if (_userName.isEmpty) {
      _snackbarService.showSnackbar(
          message: 'Please provide your preferred username');
      return;
    }
    _userService.ksUser = KsUser(UniqueKey().toString(), _userName,
        '$_userName@netvirta.com', _userName);
    await _navigationService.replaceWithTransition(HomeView(),
        duration: Duration(milliseconds: 1000),
        transitionStyle: Transition.fade);
  }

  void setUserName(String name) {
    _userName = name;
  }

  void facebookLogin() async {
    _signIn(SignIn.FACEBOOK);
  }

  void signInWithGoogle() async {
    _signIn(SignIn.GOOGLE);
  }

  void _signIn(SignIn signIn) async {
    setBusy(true);
    try {
      bool isLogin;
      switch (signIn) {
        case SignIn.GOOGLE:
          isLogin = await _userService.googleSignIn();
          break;
        case SignIn.FACEBOOK:
          isLogin = await _userService.facebookSignIn();
          break;
      }

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

enum SignIn { GOOGLE, FACEBOOK }
