import 'package:flutter/material.dart';

Future<void> navigate(BuildContext context, Widget screen) async {
  return Navigator.of(context, rootNavigator: false).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}
