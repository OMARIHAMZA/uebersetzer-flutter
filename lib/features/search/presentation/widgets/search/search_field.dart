import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'file:///D:/Documents/FlutterProjects/uebersetzer/lib/features/search/presentation/widgets/search/special_character_button.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  SearchField({@required this.onSubmitted});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();
  var isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: 1,
          decoration: _buildInputDecoration(),
          onChanged: (value) {
            setState(() {
              isSearching = true;
            });
          },
          onTap: () {
            setState(() {
              isSearching = true;
            });
          },
          controller: controller,
          onSubmitted: (value) {
            setState(() {
              isSearching = false;
            });
            controller.clear();
            widget.onSubmitted(value);
          },
        ),
        Visibility(
          visible: isSearching ? true : false,
          child: SpecialCharactersControls(
            controller: controller,
            chars: ['ä', 'ö', 'ü', 'ß'],
          ),
        )
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[300],
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Stichwort...',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        )));
  }
}

class SpecialCharactersControls extends StatefulWidget {
  final TextEditingController controller;
  final List<String> chars;

  SpecialCharactersControls({@required this.controller, @required this.chars});

  @override
  _SpecialCharactersControlsState createState() =>
      _SpecialCharactersControlsState();
}

class _SpecialCharactersControlsState extends State<SpecialCharactersControls> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.chars.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.chars.length) {
            return SpecialCharacterButton(
              controller: widget.controller,
              character: widget.chars[index],
            );
          } else {
            return CapitalizeSpecialCharacterButton(
              chars: widget.chars,
              onNewValues: (newChars) {
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }
}
