part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  SearchEvent();
}

class GetSearchResults extends SearchEvent {
  final String query;

  GetSearchResults({@required this.query});

  @override
  List get props => [query];
}
