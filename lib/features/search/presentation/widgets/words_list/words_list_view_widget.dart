import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/search/presentation/widgets/words_list/word_list_item.dart';

class WordsListView extends StatelessWidget {
  final List<Word> words;
  final ValueChanged<Word> onTap;

  WordsListView({@required this.words, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: words.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return WordsListItem(
            word: words[index],
            onTap: onTap,
          );
        },
      ),
    );
  }
}
