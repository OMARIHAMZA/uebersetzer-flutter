import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/utils/extensions.dart';

class WordsListItem extends StatelessWidget {
  final Word word;
  final ValueChanged<Word> onTap;

  WordsListItem({@required this.word, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    String subtitle = '';
    for (var i = 0; i < word.meaning.length; i++) {
      if (i + 1 >= word.meaning.length) {
        subtitle += word.meaning[i];
      } else {
        subtitle += word.meaning[i] + ', ';
      }
    }
    return ListTile(
      title: Text(word.beautify()),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Visibility(
        visible: word.type == WordType.FEMININE ||
            word.type == WordType.MASCULINE ||
            word.type == WordType.NEUTER,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 10.0,
              color: _getColorFromGender(word),
            ),
          ],
        ),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () => onTap(word),
    );
  }

  Color _getColorFromGender(Word word) {
    switch (word.type) {
      case WordType.FEMININE:
        return Colors.pink;
      case WordType.MASCULINE:
        return Colors.blue;
      case WordType.NEUTER:
        return Colors.grey[700];
      default:
        return Colors.black;
    }
  }
}
