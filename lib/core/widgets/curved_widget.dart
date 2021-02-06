import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;

  CurvedWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30),
            bottomLeft: const Radius.circular(30),
            bottomRight: const Radius.circular(30),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topRight: const Radius.circular(30)),
          ),
          child: child,
        ),
      ),
    );
  }
}
