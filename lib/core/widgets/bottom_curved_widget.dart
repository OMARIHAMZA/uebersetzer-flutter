import 'package:flutter/material.dart';

class BottomCurvedWidget extends StatelessWidget {
  final Widget child;

  BottomCurvedWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              BorderRadius.only(bottomLeft: const Radius.circular(30)),
          border: Border.all(color: Theme.of(context).primaryColor, width: 0)),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: child,
    );
  }
}
