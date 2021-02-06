import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uebersetzer/core/widgets/app_icon.dart';
import 'package:meta/meta.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onPressed;

  SectionTitle({
    @required this.title,
    @required this.iconData,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    AppIcon(iconData: iconData),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onPressed(),
                  child: Row(
                    children: [
                      Text(
                        'Alle anzeigen'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      AppIcon(
                        iconData: Icons.keyboard_arrow_right,
                        color: Colors.grey[800],
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
