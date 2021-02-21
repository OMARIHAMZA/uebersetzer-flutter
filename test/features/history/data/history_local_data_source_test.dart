import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/features/history/data/datasources/history_local_datasource.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  MockDatabaseHelper mockDatabaseHelper;
  HistoryLocalDataSourceImpl historyLocalDataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    historyLocalDataSource =
        HistoryLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final tDatabaseHelperResult = [
    {
      DatabaseHelperImpl.commonColumnId: 1,
      DatabaseHelperImpl.historyColumnQuery: 'arbeit'
    },
    {
      DatabaseHelperImpl.commonColumnId: 2,
      DatabaseHelperImpl.historyColumnQuery: 'zeit'
    },
  ];

  final List<String> tExpectedResult = ['arbeit', 'zeit'];
  group('getSearchHistory', () {
    test(
        'should fetch the result map from the database helper and transform it into a list of strings',
        () async {
      // arrange
      when(mockDatabaseHelper.queryAllRows(DatabaseHelperImpl.historyTable))
          .thenAnswer((_) async => tDatabaseHelperResult);
      // act
      final result = await historyLocalDataSource.getSearchHistory();
      // assert
      verify(mockDatabaseHelper.queryAllRows(DatabaseHelperImpl.historyTable));
      expect(listEquals(result, tExpectedResult), true);
    });
  });
}
