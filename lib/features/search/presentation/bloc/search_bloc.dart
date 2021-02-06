import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/features/search/domain/use_cases/search_for_words_usecase.dart';

part 'search_event.dart';

part 'search_state.dart';

const NO_LOCAL_DICTIONARY_ERROR =
    'The local dictionary was not found, please download it from the app settings and try again!';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchForWordsUseCase searchForWordsUseCase;

  SearchBloc({@required this.searchForWordsUseCase})
      : assert(searchForWordsUseCase != null);

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchResults) {
      yield SearchLoading();

      final resultEither =
          await searchForWordsUseCase(Params(query: event.query));

      yield resultEither.fold(
        (failure) => SearchError(message: _getErrorMessage(failure)),
        (words) => SearchLoaded(words: words),
      );
    }
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoLocalDictionaryFailure:
        return NO_LOCAL_DICTIONARY_ERROR;
    }
    return 'unknown error';
  }

  @override
  SearchState get initialState => SearchInitial();
}
