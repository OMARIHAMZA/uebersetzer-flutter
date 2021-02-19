import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';

class GetFavoritesUseCase implements UseCase<List<Word>, NoParams> {
  final FavoritesRepository repository;

  GetFavoritesUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<Word>>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}
