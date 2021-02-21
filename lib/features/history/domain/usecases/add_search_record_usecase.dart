import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/history/domain/repositories/search_history_repository.dart';

class AddSearchRecordUseCase implements UseCase<int, Params> {
  final SearchHistoryRepository repository;

  AddSearchRecordUseCase({@required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) =>
      repository.addSearchRecord(params.query);
}

class Params extends Equatable {
  final String query;

  Params({@required this.query});

  @override
  List get props => [query];
}
