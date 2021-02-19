import 'dart:convert';

import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

abstract class FavoritesLocalDataSource {
  /// Fetches favorite words from the local database
  /// Returns empty list if no data is present in the table
  Future<List<WordModel>> getFavorites();

  Future<int> addFavorite(WordModel word);

  Future<int> removeFavorite(int id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final DatabaseHelper databaseHelper;

  FavoritesLocalDataSourceImpl({@required this.databaseHelper});

  @override
  Future<int> addFavorite(WordModel word) => databaseHelper.addFavorite(word);

  @override
  Future<List<WordModel>> getFavorites() async {
    final result = await databaseHelper.getFavorites();
    if (result == null) return [];
    return WordModel.fromFavoritesJsonList(result);
  }

  @override
  Future<int> removeFavorite(int id) => databaseHelper.removeFavorite(id);
}
