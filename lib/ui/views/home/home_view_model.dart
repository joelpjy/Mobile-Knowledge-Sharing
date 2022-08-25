import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future initialise() async {
    //throw ("HELP MOBILE PLS");
    FirebaseCrashlytics.instance.crash();
  }
}
