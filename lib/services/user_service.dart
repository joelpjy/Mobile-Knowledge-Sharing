import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_knowledge_sharing_app/ui/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_NAME_KEY = 'USER_NAME';
const USER_EMAIL_KEY = 'USER_EMAIL';
const USER_ID_KEY = 'USER_ID';

class UserService {
  var isLogin = false;
  late SharedPreferences preferences;
  KsUser? ksUser;

  Future<void> initialise() async {
    preferences = await SharedPreferences.getInstance();
  }

  void _setLogin(KsUser? user) async {
    ksUser = user;
    if (user == null){
      await preferences.remove(USER_ID_KEY);
      await preferences.remove(USER_NAME_KEY);
      await preferences.remove(USER_EMAIL_KEY);
      return;
    }
    await preferences.setString(USER_ID_KEY, user.id);
    await preferences.setString(USER_NAME_KEY, user.name);
    await preferences.setString(USER_EMAIL_KEY, user.email);

  }

  Future<void> logout() async {
    _setLogin(null);
    await GoogleSignIn().signOut();
  }

  Future<bool> googleSignIn() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    var user = userCredential.user;
    if (user != null) {
      ksUser = KsUser(user.uid, user.displayName ?? '', user.email ?? '');
    }
    return user != null;
  }
}
