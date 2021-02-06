import 'package:flutter_test/flutter_test.dart';
import 'package:uebersetzer/core/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

void main(){

  group('Similarity Sorter', (){
    final tList = [
      WordModel(
          word: 'Arbeiten',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
      WordModel(
          word: 'Arbeitzeit',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
      WordModel(word: 'Arbeit', plural: 'null', meaning: [], type: WordType.FEMININE),
      WordModel(
          word: 'Abenarbeit',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
    ];
    final tExpected = [
      WordModel(word: 'Arbeit', plural: 'null', meaning: [], type: WordType.FEMININE),
      WordModel(
          word: 'Arbeiten',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
      WordModel(
          word: 'Arbeitzeit',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
      WordModel(
          word: 'Abenarbeit',
          plural: 'null',
          meaning: [],
          type: WordType.MASCULINE),
    ];
    test('should sort the results according to query similarity', () async {
      // arrange
      // act
      tList.similaritySort('Arbeit');
      // assert
      expect(listEquals(tList, tExpected), true);
    });
  });
}