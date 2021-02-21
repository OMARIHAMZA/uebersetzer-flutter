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
        return 'e, ${this.word} ${this.plural != null ? ', ' + this.plural : ''}';

      case WordType.MASCULINE:
        return 'r, ${this.word} ${this.plural != null ? ', ' + this.plural : ''}';

      case WordType.NEUTER:
        return 's, ${this.word} ${this.plural != null ? ', ' + this.plural : ''}';

      default:
        return '${this.word} ${this.type != WordType.OTHER ? '(' + this.type.toShortString().toLowerCase() + ')' : ''}';
    }
  }

  String getDescription() {
    return this.type.toShortString().capitalize() +
        '${this.plural != null ? ', ' + this.plural + ' (pl)' : ''}';
  }

  String getCopyDetails() {
    return '${this.word}\n${this.getDescription()}\n${this.meaning.toString().replaceRange(0, 1, '').replaceRange(this.meaning.toString().length - 2, this.meaning.toString().length - 1, '')}';
  }
}

extension Capitalize on String {
  String capitalize() {
    return this.toLowerCase().replaceRange(0, 1, this[0].toUpperCase());
  }
}

extension ParseToString on WordType {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String toTypeString() {
    switch (this) {
      case WordType.FEMININE:
        return 'f';

      case WordType.MASCULINE:
        return 'm';

      case WordType.NEUTER:
        return 'n';

      case WordType.ADJECTIVE:
        return 'adj';

      case WordType.ADVERB:
        return 'adv';

      case WordType.ARTICLE:
        return 'art';

      case WordType.CONJUNCTION:
        return 'conj';

      case WordType.INTERJECTION:
        return 'interj';

      case WordType.INTRANSITIVE_VERB:
        return 'vi';

      case WordType.TRANSITIVE_VERB:
        return 'vt';

      case WordType.NUMERAL:
        return 'num';

      case WordType.PLURAL:
        return 'pl';

      case WordType.PREPOSITION:
        return 'prp';

      case WordType.PRONOUN:
        return 'pron';

      case WordType.REFLEXIVE_VERB:
        return 'vr';

      case WordType.VERB:
        return 'v';

      default:
        return '';
    }
  }
}

