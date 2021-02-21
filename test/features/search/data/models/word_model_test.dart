import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

import '../../../../core/fixtures/fixture_reader.dart';
import 'package:flutter/foundation.dart';

void main() {
  test('Word Model should be a subtype of Word Entity', () async {
    // arrange
    final tWordModel = WordModel(
        word: 'Arbeit',
        plural: 'Arbeiten',
        meaning: ['Work'],
        type: WordType.NEUTER);
    // assert
    expect(tWordModel, isA<Word>());
  });

  test('should return valid model from valid json data', () async {
    // arrange
    Map<String, dynamic> json = jsonDecode(fixture('word'));
    final tWordModel = WordModel(
        word: "Abänderungsvorschlag",
        plural: "Abänderungsvorschläge",
        meaning: ["proposed amendment", "proposal of amendment"],
        type: WordType.MASCULINE,
        favoriteId: 0);
    // act
    final result = WordModel.fromJson(json);
    // assert
    expect(result, tWordModel);
  });

  test(
      'should return valid model from valid json data when there is no plural form',
      () async {
    // arrange
    Map<String, dynamic> json = jsonDecode(fixture('word_without_plural_form'));
    final tWordModel = WordModel(
        word: "Abarbeitung",
        plural: null,
        meaning: ["execution"],
        type: WordType.FEMININE,
        favoriteId: 0);
    // act
    final result = WordModel.fromJson(json);
    // assert
    expect(result, tWordModel);
  });

  test('should return valid model from valid json data when there is no gender',
      () async {
    // arrange
    Map<String, dynamic> json = jsonDecode(fixture('word_without_gender'));
    final tWordModel = WordModel(
        word: "thermischer Abbau",
        plural: null,
        meaning: ["thermal degradation"],
        type: WordType.OTHER,
        favoriteId: 0);
    // act
    final result = WordModel.fromJson(json);
    // assert
    expect(result, tWordModel);
  });
}
