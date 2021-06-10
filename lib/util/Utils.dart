import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// Check Internet Connection
Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

// check Map and value  and if null fill with ""
String getFieldValue(Map map, String key) {
  String str = '';
  if (map.containsKey(key)) {
    String s = map[key];
    if (s != null) {
      str = s.toString();
    }
  }
  return str;
}

int getFieldValueInteger(Map map, String key) {
  int value = 0;
  if (map.containsKey(key)) {
    int s = map[key];
    if (s != null) {
      value = s;
    }
  }
  return value;
}

Future<User> facebookLogin() async {
  User currentUser;
  final FacebookLogin fbLogin = new FacebookLogin();
  final FirebaseAuth auth = FirebaseAuth.instance;
//For Web View Only
  fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

  try {
    final FacebookLoginResult facebookLoginResult =
        await fbLogin.logIn(['email', 'public_profile']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      final AuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken.token);
      final UserCredential user = await auth.signInWithCredential(credential);

      currentUser = auth.currentUser;
      currentUser = user.user;
      return currentUser;
    }
  } catch (e) {
    print(e);
  }
  return currentUser;
}
