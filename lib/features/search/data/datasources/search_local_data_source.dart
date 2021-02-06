import 'package:uebersetzer/features/search/domain/entites/word.dart';

abstract class SearchLocalDataSource {
  /// Searches for records in the local databases which are relevant to the entered query
  ///
  /// throw [NoLocalDictionaryException] if the connection to the local dictionary fails
  Future<List<Word>> search(String query);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  @override
  Future<List<Word>> search(String query) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
