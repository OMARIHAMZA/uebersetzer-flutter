part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent extends Equatable {
  SearchHistoryEvent();
}

class GetSearchHistoryEvent extends SearchHistoryEvent {}

class AddSearchRecordEvent extends SearchHistoryEvent {
  final String query;

  AddSearchRecordEvent({@required this.query});

  @override
  List get props => [query];
}

class DeleteSearchRecordEvent extends SearchHistoryEvent {
  final int id;

  DeleteSearchRecordEvent({@required this.id});

  @override
  List get props => [id];
}

class ClearSearchHistoryEvent extends SearchHistoryEvent {}
