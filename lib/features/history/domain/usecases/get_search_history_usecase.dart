import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';
import 'package:meta/meta.dart';

class GetSearchHistoryUseCase implements UseCase<List<HistoryEntry>, NoParams> {
  final SearchHistoryRepository repository;

  GetSearchHistoryUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<HistoryEntry>>> call(NoParams params) =>
      repository.getSearchHistory();
}
