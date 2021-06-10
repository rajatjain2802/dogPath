import 'package:dog_path_app/res/AppColor.dart';
import 'package:dog_path_app/res/Dimensions.dart';
import 'package:dog_path_app/widget/TextView.dart';
import 'package:flutter/material.dart';

AppBar toolBar({
  @required String toolBarTitle,
  Color toolBarTitleColor = AppColor.txtColorGray,
  @required VoidCallback onClick,
  IconData toolBarIcon = Icons.arrow_back,
  Color toolBarIconColor = AppColor.white,
  Color toolBarBgColor = AppColor.primary,
  double elevation = 5,
  bool isImageTitle = false,
  String imagePath = '',
  double imageWidth = 0.0,
  double imageHeight = 0.0,
  BoxFit fit = BoxFit.none,
  List<Widget> actions,
}) {
  return AppBar(
    titleSpacing: 0,
    title: textView(
        title: toolBarTitle, fontColor: toolBarTitleColor, fontSize: Dimensions.txtSize16px),
    iconTheme: IconThemeData(color: AppColor.white),
    elevation: elevation,
    backgroundColor: toolBarBgColor,
    actions: actions,
    centerTitle: true,
    leading: Container(),
  );
}
