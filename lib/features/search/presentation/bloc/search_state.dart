part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Word> words;

  SearchLoaded({@required this.words});

  @override
  List<Object> get props => [words];
}

class SearchError extends SearchState {
  final String message;

  SearchError({@required this.message});

  @override
  List<Object> get props => [message];
}

class SearchEmpty extends SearchState {
  @override
  List<Object> get props => [];
}
