import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordActionButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onPressed;

  WordActionButton({
    @required this.title,
    @required this.iconData,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 55,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        padding: EdgeInsets.all(5.0),
        color: Colors.black26,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
