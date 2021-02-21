import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';
import 'package:meta/meta.dart';

class ClearSearchHistoryUseCase implements UseCase<void, NoParams> {
  final SearchHistoryRepository repository;

  ClearSearchHistoryUseCase({@required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      repository.clearSearchHistory();
}
