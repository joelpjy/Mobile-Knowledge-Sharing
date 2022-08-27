import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_knowledge_sharing_app/models/user.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/splash/splash_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_SIGNIN_METHOD = 'USER_SIGNIN_METHOD';
const USER_ID_KEY = 'USER_ID';

class UserService {
  bool get isLogin => ksUser != null;
  late SharedPreferences preferences;
  KsUser? ksUser;

  Future<void> initialise() async {
    preferences = await SharedPreferences.getInstance();
    await _initUser();
  }

  Future<void> _initUser() async {
    var uid = preferences.getString(USER_ID_KEY);
    if (uid != null) {
      var signInMethod = preferences.getInt(USER_SIGNIN_METHOD);
      switch (signInMethod){
        case 0:
          await googleSignIn(isLoggedIn: true);
          break;
        case 1:
          await facebookSignIn(isLoggedIn: true);
          break;
      }
    }
  }

  void _setLogin(int signInMethod, KsUser? user) async {
    ksUser = user;
    if (user == null) {
      await preferences.clear();
      return;
    }
    await preferences.setString(USER_ID_KEY, user.id);
    await preferences.setInt(USER_SIGNIN_METHOD, signInMethod);
  }

  Future<void> logout() async {
    _setLogin(0, null);
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<bool> googleSignIn({bool isLoggedIn = false}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser;
    if (isLoggedIn) {
      googleUser = await GoogleSignIn().signInSilently();
    } else {
      googleUser = await GoogleSignIn().signIn();
    }

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
    return _firebaseLogin(SignIn.GOOGLE, userCredential);
  }

  Future<bool> facebookSignIn({bool isLoggedIn = false}) async {
    // Trigger the sign-in flow
    final LoginResult loginResult;
    final AccessToken? accessToken;
    if (!isLoggedIn) {
      loginResult = await FacebookAuth.instance.login();
      accessToken = loginResult.accessToken;
    } else {
      accessToken = await FacebookAuth.instance.accessToken;
    }
    if (accessToken == null) {
      return false;
    }

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.token);
    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    return _firebaseLogin(SignIn.FACEBOOK, userCredential);
  }

  bool _firebaseLogin(SignIn signIn, UserCredential userCredential) {
    var user = userCredential.user;
    if (user != null) {
      ksUser = KsUser(
          user.uid, user.displayName ?? '', user.email ?? '', user.photoURL);
      _setLogin(signIn.index, ksUser);
    }
    return user != null;
  }
}
