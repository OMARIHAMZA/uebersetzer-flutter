part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  FavoritesEvent();
}

class GetFavoritesEvent extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final Word word;

  AddFavoriteEvent({@required this.word});

  @override
  List get props => [word];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int id;

  RemoveFavoriteEvent({@required this.id});

  @override
  List get props => [id];
}
