import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/history/data/model/history_entry_model.dart';

abstract class HistoryLocalDataSource {
  /// Fetches all records from [SearchHistory] Table
  ///
  /// if none exists then an empty list is returned
  Future<List<HistoryEntryModel>> getSearchHistory();

  /// Inserts a new record using the search query
  Future<int> insertSearchRecord(String query);

  /// Deletes a record using the search query
  Future<int> deleteSearchRecord(int id);

  /// Clears the entire history table
  Future<void> clearSearchHistory();
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  HistoryLocalDataSourceImpl({@required this.databaseHelper});

  @override
  Future<void> clearSearchHistory() =>
      databaseHelper.clearTable(DatabaseHelperImpl.historyTable);

  @override
  Future<int> deleteSearchRecord(int id) => databaseHelper.delete(
        id,
        DatabaseHelperImpl.historyTable,
      );

  @override
  Future<List<HistoryEntryModel>> getSearchHistory() async {
    List<Map<String, dynamic>> rows =
        await databaseHelper.queryAllRows(DatabaseHelperImpl.historyTable);
    return HistoryEntryModel.fromJsonList(rows);
  }

  @override
  Future<int> insertSearchRecord(String query) => databaseHelper.insert(
        {
          DatabaseHelperImpl.historyColumnQuery: query,
        },
        DatabaseHelperImpl.historyTable,
      );
}
