import 'package:dog_path_app/base/BaseState.dart';
import 'package:dog_path_app/res/AppColor.dart';
import 'package:dog_path_app/res/Dimensions.dart';
import 'package:dog_path_app/res/Strings.dart';
import 'package:dog_path_app/widget/ImageViewAssets.dart';
import 'package:dog_path_app/widget/TextView.dart';
import 'package:flutter/material.dart';

/*
* Created by Rajat Jain 09/06/2021
 */
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  Widget getBuildWidget(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageViewAsset(
              imagePath: 'asset/images/image.gif',
              imageWidth: 140,
              imageHeight: 140,
              fit: BoxFit.contain),
          textView(
              title: Strings.dogPathTxt,
              fontSize: Dimensions.txtSize36px,
              fontWeight: FontWeight.w500,
              margin: EdgeInsets.only(bottom: 10),
              textAlign: TextAlign.center),
          textView(title: Strings.by, textAlign: TextAlign.center),
          textView(
              title: Strings.virtouStackTxt,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              fontSize: Dimensions.txtSize18px,
              maxLine: 2,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return null;
  }

  @override
  void onScreenReady(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}
