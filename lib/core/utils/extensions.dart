import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

extension SimilaritySorter on List<WordModel> {
  void similaritySort(String target) {
    this.sort((a, b) => _getSimilarity(a, b, target));
  }

  int _getSimilarity(WordModel a, WordModel b, String target) {
    final aToTarget = a.word.similarityTo(target);
    final bToTarget = b.word.similarityTo(target);
    if (aToTarget > bToTarget) {
      return -1;
    } else if (aToTarget < bToTarget) {
      return 1;
    } else {
      return 0;
    }
  }
}

extension WordBeautify on Word {
  String beautify() {
    switch (this.type) {
      case WordType.FEMININE:
        return 'e, ${this.word} ${this.plural != null ? ',' + this.plural : ''}';

      case WordType.MASCULINE:
        return 'r, ${this.word} ${this.plural != null ? ',' + this.plural : ''}';

      case WordType.NEUTER:
        return 's, ${this.word} ${this.plural != null ? ',' + this.plural : ''}';

      default:
        return '${this.word} ${this.type != WordType.OTHER ? '(' + this.type.toShortString().toLowerCase() + ')' : ''}';
    }
  }
}
