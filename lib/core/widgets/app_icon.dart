import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;

  AppIcon({@required this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: color == null ? Colors.grey : color,
      size: 20.0,
    );
  }
}
