import 'dart:convert';

import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/utils/extensions.dart';

class WordModel extends Word {
  final String word;
  final String plural;
  final List<String> meaning;
  final WordType type;
  final int favoriteId;

  WordModel(
      {@required this.word,
      @required this.plural,
      @required this.meaning,
      @required this.type,
      this.favoriteId})
      : super(
          word: word,
          plural: plural,
          meaning: meaning,
          type: type,
        );

  Map<String, dynamic> toJson() => {
        'word': word,
        'plural': plural,
        'meaning': meaning,
        'type': type.toTypeString(),
        'favoriteId': favoriteId
      };

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
      favoriteId: json.containsKey('fav_id') && json['fav_id'] != null  ? json['fav_id'] : 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'word': word,
        'gender': type.toTypeString(),
        'plural': plural,
        'meaning': jsonEncode(meaning),
        'favoriteId': favoriteId
      };

  static List<WordModel> fromJsonList(List<Map<String, dynamic>> jsons) {
    if (jsons == null) return [];
    List<WordModel> result = [];
    for (var currentJson in jsons) {
      result.add(WordModel.fromJson(currentJson));
    }
    return result;
  }

  static List<WordModel> fromFavoritesJsonList(
      List<Map<String, dynamic>> jsons) {
    if (jsons == null) return [];
    List<WordModel> result = [];
    for (var currentFav in jsons) {
      var currentWord = jsonDecode(currentFav['word']);
      currentWord['fav_id'] = currentFav[DatabaseHelperImpl.favoritesColumnId];
      result.add(WordModel.fromJson(currentWord));
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
