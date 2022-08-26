import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_knowledge_sharing_app/app/app.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() async {
  // execute blocking functions only after binding completes
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // pre-launch setup and config
  await setupLocator();
  // setupDialogUi();
  // setupSnackbar();
  // var firebaseCrashlyticsService = locator<FirebaseCrashlyticsService>();
  // await firebaseCrashlyticsService.initialise();
  // launch app in portrait mode
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MyApp());
  // runZonedGuarded(() {
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //       .then((value) => runApp(App()));
  // }, firebaseCrashlyticsService.recordError);
}
