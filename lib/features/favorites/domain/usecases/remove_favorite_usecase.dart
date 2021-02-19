import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase implements UseCase<int, Params> {
  final FavoritesRepository repository;

  RemoveFavoriteUseCase({@required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) =>
      repository.removeFavorite(params.id);
}

class Params {
  final int id;

  Params({@required this.id});
}
