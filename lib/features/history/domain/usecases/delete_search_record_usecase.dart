import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';

class DeleteSearchRecordUseCase implements UseCase<int, Params> {
  final SearchHistoryRepository repository;

  DeleteSearchRecordUseCase({@required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) =>
      repository.deleteSearchRecord(params.id);
}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  List get props => [id];
}
