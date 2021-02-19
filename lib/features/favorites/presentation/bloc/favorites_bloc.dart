import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/core/usecases/usecase.dart';
import 'package:uebersetzer/features/favorites/domain/usecases/add_favorite_usecase.dart'
    as add;
import 'package:uebersetzer/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:uebersetzer/features/favorites/domain/usecases/remove_favorite_usecase.dart'
    as remove;
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavorites;
  final add.AddFavoriteUseCase addFavorite;
  final remove.RemoveFavoriteUseCase removeFavorite;

  FavoritesBloc({
    @required this.getFavorites,
    @required this.addFavorite,
    @required this.removeFavorite,
  });

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavoritesEvent) {
      yield FavoritesLoading();
      final result = await getFavorites(NoParams());
      yield* result.fold((error) async* {
        yield FavoritesEmpty();
      }, (favorites) async* {
        if (favorites.isEmpty) {
          yield FavoritesEmpty();
        } else {
          yield FavoritesLoaded(favorites: favorites);
        }
      });
    } else if (event is AddFavoriteEvent) {
      yield FavoritesLoading();
      final result = await addFavorite.call(add.Params(word: event.word));
      yield* result.fold((failure) async* {
        if (failure is DatabaseFailure) {
          print(failure.message);
          yield FavoriteLoadingFailed(message: failure.message);
        }
      }, (id) async* {
        yield FavoriteAdded(id: id);
      });
    } else if (event is RemoveFavoriteEvent) {
      yield FavoritesLoading();
      final result = await removeFavorite.call(remove.Params(id: event.id));
      yield* result.fold((failure) async* {
        if (failure is DatabaseFailure) {
          print(failure.message);
          yield FavoriteLoadingFailed(message: failure.message);
        }
      }, (id) async* {
        yield FavoriteRemoved(id: id);
      });
    }
  }

  @override
  FavoritesState get initialState => FavoritesInitial();
}
