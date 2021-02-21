import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/history/data/datasources/history_local_datasource.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';
import 'package:meta/meta.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final HistoryLocalDataSource localDataSource;

  SearchHistoryRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, int>> addSearchRecord(String query) async {
    try {
      return Right(await localDataSource.insertSearchRecord(query));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      return Right(await localDataSource.clearSearchHistory());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteSearchRecord(int id) async {
    try {
      return Right(await localDataSource.deleteSearchRecord(id));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HistoryEntry>>> getSearchHistory() async {
    try {
      return Right(await localDataSource.getSearchHistory());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
