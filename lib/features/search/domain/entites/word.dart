import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Word extends Equatable {
  final String word;
  final String plural;
  final List<String> meaning;
  final WordType type;

  Word({
    @required this.word,
    @required this.plural,
    @required this.meaning,
    @required this.type,
  });

  @override
  List get props => [word, plural, meaning, type];
}

enum WordType {
  MASCULINE,
  FEMININE,
  NEUTER,
  PLURAL,
  ADJECTIVE,
  ADVERB,
  INTRANSITIVE_VERB,
  TRANSITIVE_VERB,
  VERB,
  INTERJECTION,
  PREPOSITION,
  CONJUNCTION,
  REFLEXIVE_VERB,
  NUMERAL,
  ARTICLE,
  PRONOUN,
  OTHER
}

extension ParseToString on WordType {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last;
  }
}

