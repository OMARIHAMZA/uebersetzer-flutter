import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  MockDatabaseHelper databaseHelper;
  FavoritesLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    databaseHelper = MockDatabaseHelper();
    localDataSourceImpl =
        FavoritesLocalDataSourceImpl(databaseHelper: databaseHelper);
  });

  final tWordModel = WordModel(
      word: 'Test',
      plural: 'test',
      meaning: ['test'],
      type: WordType.MASCULINE);

  group('addFavorite', () {
    test('should call DatabaseHelper\'s adFavorite method with the WordModel',
        () async {
      // arrange
      when(localDataSourceImpl.addFavorite(any))
          .thenAnswer((realInvocation) async => 1);

      // act
      final result = await localDataSourceImpl.addFavorite(tWordModel);
      // assert
      verify(localDataSourceImpl.addFavorite(tWordModel));
      expect(result, 1);
    });
  });

  group('getFavorites', () {
    test(
        'should call databases helper get favorites method and return the data',
        () async {
      // arrange
      final expected = [tWordModel.toMap()];
      when(databaseHelper.getFavorites())
          .thenAnswer((realInvocation) async => expected);
      // act
      final result = await localDataSourceImpl.getFavorites();
      // assert
      verify(databaseHelper.getFavorites());
      expect(result.length, expected.length);
    });
  });

  group('removeFavorite', () {
    test('should call DatabaseHelper delete method with the word id', () async {
      // arrange
      when(databaseHelper.removeFavorite(any))
          .thenAnswer((realInvocation) async => 1);
      // act
      await localDataSourceImpl.removeFavorite(1);
      // assert
      verify(databaseHelper.removeFavorite(1));
    });
  });
}
