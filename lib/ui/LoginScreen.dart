import 'package:dog_path_app/base/BaseState.dart';
import 'package:dog_path_app/res/AppColor.dart';
import 'package:dog_path_app/res/Dimensions.dart';
import 'package:dog_path_app/res/Strings.dart';
import 'package:dog_path_app/util/Utils.dart';
import 'package:dog_path_app/widget/TextView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

/*
* Created by Rajat Jain 09/06/2021
 */
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends BaseState<LoginScreen> {
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
              facebookLogin().then((user) {
                if (user != null) {
                  showProgress(false);
                  Navigator.pushNamed(context, '/home');
                } else {
                  showProgress(false);
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
}
