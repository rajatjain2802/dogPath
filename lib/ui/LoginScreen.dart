import 'package:dog_path_app/base/BaseState.dart';
import 'package:dog_path_app/res/AppColor.dart';
import 'package:dog_path_app/res/Dimensions.dart';
import 'package:dog_path_app/res/Strings.dart';
import 'package:dog_path_app/widget/TextView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FacebookLogin fbLogin = new FacebookLogin();
  bool isFacebookLoginIn = false;

  @override
  Widget getBuildWidget(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textView(
              title: Strings.signInTxt,
              fontColor: AppColor.white,
              fontSize: Dimensions.txtSize18px,
              textAlign: TextAlign.center,
              margin: EdgeInsets.only(bottom: 15)),
          textView(
              title: Strings.signInWithFbTxt,
              fontColor: AppColor.white,
              textAlign: TextAlign.center,
              margin: EdgeInsets.only(bottom: 15)),
          SignInButton(
            Buttons.FacebookNew,
            onPressed: () {
              showProgress(true);
              facebookLogin(context).then((user) {
                if (user != null) {
                  showProgress(false);
                  Navigator.pushNamed(context, '/home');
                } else {
                  print('Error while Login.');
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return null;
  }

  @override
  void onScreenReady(BuildContext context) {}

  Future<User> facebookLogin(BuildContext context) async {
    User currentUser;
    fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult =
          await fbLogin.logIn(['email', 'public_profile']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(facebookAccessToken.token);
        final UserCredential user = await auth.signInWithCredential(credential);
        // assert(user.user.email != null);
        // assert(user.user.displayName != null);
        // assert(!user.user.isAnonymous);
        // assert(await user.user.getIdToken() != null);
        currentUser = auth.currentUser;
        // assert(user.user.uid == currentUser.uid);
        currentUser = user.user;
        return currentUser;
      }
    } catch (e) {
      print(e);
    }
    return currentUser;
  }
}
