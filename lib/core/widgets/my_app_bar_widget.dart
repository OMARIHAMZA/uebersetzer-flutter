import 'package:flutter/material.dart';
import 'package:uebersetzer/core/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAppBar extends AppBar {
  final BuildContext context;
  final String mTitle;
  final TextStyle mTextStyle;

  MyAppBar({this.context, this.mTitle, this.mTextStyle})
      : super(
          title: Text(
            mTitle ?? AppLocalizations.of(context).appName,
            style: mTextStyle ?? kDefaultAppBarTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
        );
}
