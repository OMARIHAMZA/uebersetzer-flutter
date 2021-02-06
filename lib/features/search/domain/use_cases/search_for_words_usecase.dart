import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/features/search/domain/repositories/search_repository.dart';
import 'package:meta/meta.dart';

class SearchForWordsUseCase extends UseCase<List<Word>, Params> {
  final SearchRepository searchRepository;

  SearchForWordsUseCase({@required this.searchRepository});

  @override
  Future<Either<Failure, List<Word>>> call(Params params) {
    return searchRepository.searchForWords(params.query);
  }
}

class Params extends Equatable {
  final String query;

  Params({@required this.query});

  @override
  List get props => [query];
}
