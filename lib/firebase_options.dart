// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEecAxjea9z0mzRm1labtVoHcdjvm6HQw',
    appId: '1:639612988752:android:4a12b93d3ad5c03b61d055',
    messagingSenderId: '639612988752',
    projectId: 'mobile-ks',
    storageBucket: 'mobile-ks.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9ewj8-YtdAl-FC0PaAvX6eer_Jd71JY0',
    appId: '1:639612988752:ios:94d7dee661205d5d61d055',
    messagingSenderId: '639612988752',
    projectId: 'mobile-ks',
    storageBucket: 'mobile-ks.appspot.com',
    androidClientId: '639612988752-i6qruksurmsvjfb1vdlmhlkvv61v12lv.apps.googleusercontent.com',
    iosClientId: '639612988752-rdhfglvpr57l5s29f2k7rntp5aemgr2g.apps.googleusercontent.com',
    iosBundleId: 'com.netvirta.mobileKnowledgeSharingApp',
  );
}
