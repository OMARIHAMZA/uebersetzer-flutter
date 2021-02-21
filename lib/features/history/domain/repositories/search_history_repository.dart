import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';

abstract class SearchHistoryRepository {
  Future<Either<Failure, List<HistoryEntry>>> getSearchHistory();

  Future<Either<Failure, int>> addSearchRecord(String query);

  Future<Either<Failure, int>> deleteSearchRecord(int id);

  Future<Either<Failure, void>> clearSearchHistory();
}
