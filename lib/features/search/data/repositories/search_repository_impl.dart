import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/core/errors/exceptions.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/data/datasources/search_local_data_source.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/features/search/domain/repositories/search_repository.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/utils/similarity_sort.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;
  final DatabaseHelper databaseHelper;

  SearchRepositoryImpl(
      {@required this.localDataSource, @required this.databaseHelper});

  @override
  Future<Either<Failure, List<Word>>> searchForWords(String query) async {
    try {
      final mapFromDatabase = await databaseHelper.performSearchQuery(query);
      final list = WordModel.fromJsonList(mapFromDatabase);
      list.similaritySort(query);
      return Right(list);
    } on NoLocalDictionaryException {
      return Left(NoLocalDictionaryFailure());
    } catch (e) {
      print(e.toString());
    }
  }
}
