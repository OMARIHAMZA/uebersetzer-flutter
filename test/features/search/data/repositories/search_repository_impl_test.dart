import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/core/errors/exceptions.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/data/datasources/search_local_data_source.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/data/repositories/search_repository_impl.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:flutter/foundation.dart';

class MockSearchLocalDataSource extends Mock implements SearchLocalDataSource {}

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  SearchRepositoryImpl searchRepositoryImpl;
  MockSearchLocalDataSource mockLocalDataSource;
  MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockLocalDataSource = MockSearchLocalDataSource();
    mockDatabaseHelper = MockDatabaseHelper();
    searchRepositoryImpl = SearchRepositoryImpl(
        localDataSource: mockLocalDataSource,
        databaseHelper: mockDatabaseHelper);
  });

  try {
    group('searchForWords', () {
      /// Test Cases
      ///
      /// 1 - Should throw NoLocalDictionaryFailure when the database is not found
      ///
      /// 2 - else, the method must perform the search query
      ///

      const tQuery = 'Arbeit';

      test(
          'should return [NoLocalDictionaryFailure] when the local database is not found',
          () async {
        // arrange
        when(mockDatabaseHelper.performSearchQuery(any))
            .thenThrow(NoLocalDictionaryException());
        // act
        final result = await searchRepositoryImpl.searchForWords(tQuery);
        // assert
        expect(result, equals(Left(NoLocalDictionaryFailure())));
      });

      test('should perform the search query', () async {
        // arrange
        // act
        await searchRepositoryImpl.searchForWords(tQuery);
        // assert
        verify(mockDatabaseHelper.performSearchQuery(tQuery));
      });

      final tJson1 = {
        'word': '1',
        'plural': 'null',
        'meaning': '[\"1\",\"2\"]',
        'gender': 'f'
      };

      final tJson2 = {
        'word': '2',
        'plural': '[\"Arbeiten\"]',
        'meaning': '[\"3\",\"4\"]',
        'gender': 'vi'
      };

      final tJson3 = {
        'word': '1',
        'plural': '[\"Plural\"]',
        'meaning': '[\"4\",\"5\"]',
        'gender': 'null'
      };

      final tJson4 = {
        'word': '1',
        'plural': 'null',
        'meaning': '[\"5\",\"6\"]',
        'gender': 'pl'
      };
      test(
          'should return the results in the same order as returned from the 4 performed queries',
          () async {
        // arrange
        when(mockDatabaseHelper.performSearchQuery(tQuery))
            .thenAnswer((_) async {
          return [tJson1, tJson2, tJson3, tJson4];
        });

        // act
        final result = await searchRepositoryImpl.searchForWords(tQuery);
        // assert
        final expected = (List<Word>.from([
          WordModel.fromJson(tJson1),
          WordModel.fromJson(tJson2),
          WordModel.fromJson(tJson3),
          WordModel.fromJson(tJson4),
        ]));
        result.fold(
          (l) => expect(false, true),
          (r) => expect(listEquals(r, expected), true),
        );
      });
    });
  } catch (e, s) {
    print(s);
  }
}
