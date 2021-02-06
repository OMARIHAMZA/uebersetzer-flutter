import 'package:flutter/material.dart';
import 'package:uebersetzer/core/utils/constants.dart';

class MyAppBar extends AppBar {
  final String mTitle;
  final TextStyle mTextStyle;

  MyAppBar({this.mTitle, this.mTextStyle})
      : super(
          title: Text(
            mTitle ?? 'Das Woerterbuch.',
            style: mTextStyle ?? kDefaultAppBarTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
        );
}
