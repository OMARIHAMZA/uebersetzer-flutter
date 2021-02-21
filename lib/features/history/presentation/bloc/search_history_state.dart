part of 'search_history_bloc.dart';

abstract class SearchHistoryState extends Equatable {
  SearchHistoryState();
}

class SearchHistoryInitial extends SearchHistoryState {
  @override
  List<Object> get props => [];
}

class SearchHistoryLoading extends SearchHistoryState {
  @override
  List<Object> get props => [];
}

class SearchHistoryLoaded extends SearchHistoryState {
  final List<HistoryEntry> history;

  SearchHistoryLoaded({@required this.history});

  @override
  List<Object> get props => [history];
}

class SearchHistoryEmpty extends SearchHistoryState {
  @override
  List<Object> get props => [];
}

class SearchHistoryError extends SearchHistoryState {
  final String message;

  SearchHistoryError({@required this.message});

  @override
  List<Object> get props => [message];
}
