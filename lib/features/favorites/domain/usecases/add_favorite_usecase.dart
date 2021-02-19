import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';

class AddFavoriteUseCase implements UseCase<int, Params> {
  final FavoritesRepository repository;

  AddFavoriteUseCase({@required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) =>
      repository.addFavorite(params.word);
}

class Params extends Equatable {
  final Word word;

  Params({@required this.word});

  @override
  List get props => [word];
}
