import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Word>>> getFavorites();

  Future<Either<Failure, int>> addFavorite(Word word);

  Future<Either<Failure, int>> removeFavorite(int id);
}
