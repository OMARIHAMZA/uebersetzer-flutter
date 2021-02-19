import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:uebersetzer/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

class MockFavoritesLocalDataSource extends Mock
    implements FavoritesLocalDataSource {}

void main() {
  MockFavoritesLocalDataSource mockFavoritesLocalDataSource;
  FavoritesRepositoryImpl favoritesRepositoryImpl;

  setUp(() {
    mockFavoritesLocalDataSource = MockFavoritesLocalDataSource();
    favoritesRepositoryImpl =
        FavoritesRepositoryImpl(localDataSource: mockFavoritesLocalDataSource);
  });

  final tWordModel = WordModel(
      word: 'word', plural: 'pl', meaning: ['test'], type: WordType.MASCULINE);

  group('addFavorite', () {
    test('should call local data source and add the favorite item', () async {
      // arrange
      when(mockFavoritesLocalDataSource.addFavorite(any))
          .thenAnswer((realInvocation) async => 1);
      // act
      final result = await favoritesRepositoryImpl.addFavorite(tWordModel);
      // assert
      verify(mockFavoritesLocalDataSource.addFavorite(tWordModel));
      expect(result, Right(1));
    });
  });
}
