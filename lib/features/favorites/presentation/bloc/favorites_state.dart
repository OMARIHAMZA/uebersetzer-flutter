part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoaded extends FavoritesState {
  final List<Word> favorites;

  FavoritesLoaded({@required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesEmpty extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoriteAdded extends FavoritesState {
  final int id;

  FavoriteAdded({@required this.id});

  @override
  List get props => [id];
}

class FavoriteRemoved extends FavoritesState {
  final int id;

  FavoriteRemoved({@required this.id});

  @override
  List get props => [id];
}

class FavoriteLoadingFailed extends FavoritesState {
  final String message;

  FavoriteLoadingFailed({@required this.message});

  @override
  List get props => [message];
}
