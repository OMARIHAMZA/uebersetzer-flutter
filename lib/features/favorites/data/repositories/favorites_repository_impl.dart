import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:uebersetzer/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, int>> addFavorite(Word word) async {
    try {
      return Right(await localDataSource.addFavorite(word));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Word>>> getFavorites() async {
    try {
      final result = await localDataSource.getFavorites();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> removeFavorite(int id) async {
    try {
      return Right(await localDataSource.removeFavorite(id));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
