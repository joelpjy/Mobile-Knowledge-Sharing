import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile_knowledge_sharing_app/app/config.locator.dart';
import 'package:mobile_knowledge_sharing_app/services/user_service.dart';

class FirebaseCrashlyticsUtils {
  static void log(String callerName, String methodName, String msg) {
    var breadCrumb =
        'callerName[$callerName], methodName[$methodName], message[$msg], user[${locator<UserService>().ksUser?.id}]';
    FirebaseCrashlytics.instance.log(breadCrumb);
  }
}
