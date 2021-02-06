import 'dart:convert';

import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';
import 'package:string_similarity/string_similarity.dart';

class WordModel extends Word {
  final String word;
  final String plural;
  final List<String> meaning;
  final WordType type;

  WordModel({
    @required this.word,
    @required this.plural,
    @required this.meaning,
    @required this.type,
  }) : super(
          word: word,
          plural: plural,
          meaning: meaning,
          type: type,
        );

  factory WordModel.fromJson(Map<String, dynamic> json) {
    var plurals = [];
    try {
      plurals = List.from(jsonDecode(json['plural']));
    } catch (_) {}
    return WordModel(
      word: json['word'],
      plural: plurals.length > 0
          ? plurals.firstWhere((element) => element.toString().isNotEmpty) ??
              null
          : null,
      meaning: List<String>.from(jsonDecode((json['meaning']))),
      type: _getWordType(json['gender']),
    );
  }

  static List<WordModel> fromJsonList(List<Map<String, dynamic>> jsons) {
    if (jsons == null) return [];
    List<WordModel> result = [];
    for (var currentJson in jsons) {
      result.add(WordModel.fromJson(currentJson));
    }
    return result;
  }

  static WordType _getWordType(String type) {
    switch (type) {
      case 'f':
        return WordType.FEMININE;

      case 'm':
        return WordType.MASCULINE;

      case 'n':
        return WordType.NEUTER;

      case 'adj':
        return WordType.ADJECTIVE;

      case 'adv':
        return WordType.ADVERB;

      case 'art':
        return WordType.ARTICLE;

      case 'conj':
        return WordType.CONJUNCTION;

      case 'interj':
        return WordType.INTERJECTION;

      case 'vi':
        return WordType.INTRANSITIVE_VERB;

      case 'vt':
        return WordType.TRANSITIVE_VERB;

      case 'num':
        return WordType.NUMERAL;

      case 'pl':
        return WordType.PLURAL;

      case 'prp':
        return WordType.PREPOSITION;

      case 'pron':
        return WordType.PRONOUN;

      case 'vr':
        return WordType.REFLEXIVE_VERB;

      case 'v':
        return WordType.VERB;

      default:
        return WordType.OTHER;
    }
  }
}
