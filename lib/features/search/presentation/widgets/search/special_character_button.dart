import 'package:flutter/material.dart';

class SpecialCharacterButton extends StatefulWidget {
  final TextEditingController controller;
  final String character;

  SpecialCharacterButton({@required this.controller, @required this.character});

  @override
  _SpecialCharacterButtonState createState() => _SpecialCharacterButtonState();
}

class _SpecialCharacterButtonState extends State<SpecialCharacterButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          widget.controller.text += widget.character;
          widget.controller.selection =
              TextSelection.collapsed(offset: widget.controller.text.length);
        },
        child: Text(
          widget.character,
          style: TextStyle(color: Colors.white),
        ),
        shape: CircleBorder(),
        color: Colors.black26,
        elevation: 0,
      ),
    );
  }
}

class CapitalizeSpecialCharacterButton extends StatefulWidget {
  final List<String> chars;
  final Function onNewValues;

  CapitalizeSpecialCharacterButton(
      {@required this.chars, @required this.onNewValues});

  @override
  _CapitalizeSpecialCharacterButtonState createState() =>
      _CapitalizeSpecialCharacterButtonState();
}

class _CapitalizeSpecialCharacterButtonState
    extends State<CapitalizeSpecialCharacterButton> {
  var capitalize = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          capitalize = !capitalize;
          for (int i = 0; i < widget.chars.length; i++) {
            widget.chars[i] = capitalize
                ? widget.chars[i].toUpperCase()
                : widget.chars[i].toLowerCase();
          }
          widget.onNewValues(widget.chars);
        },
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        color: Colors.black26,
        elevation: 0,
      ),
    );
  }
}
