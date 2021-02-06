import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/features/search/domain/use_cases/search_for_words_usecase.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';

class MockSearchForWordsUseCase extends Mock implements SearchForWordsUseCase {}

void main() {
  MockSearchForWordsUseCase mockSearchForWordsUseCase;
  SearchBloc searchBloc;

  setUp(() {
    mockSearchForWordsUseCase = MockSearchForWordsUseCase();
    searchBloc = SearchBloc(searchForWordsUseCase: mockSearchForWordsUseCase);
  });

  test('[SearchInitial] should be the initial state', () {
    expect(searchBloc.initialState, SearchInitial());
  });

  group('searchForWords', () {
    // The event takes in a string
    final tQuery = 'Arbeit';
    // This is the data returned by the use case
    final result = [
      Word(
        word: tQuery,
        plural: '${tQuery}en',
        meaning: ['Work'],
        type: WordType.FEMININE,
      )
    ];

    test('should fetch data from the use case', () async {
      // arrange
      when(mockSearchForWordsUseCase(any))
          .thenAnswer((realInvocation) async => Right(result));
      // act
      searchBloc.dispatch(GetSearchResults(query: tQuery));
      await untilCalled(mockSearchForWordsUseCase(any));
      // assert
      verify(mockSearchForWordsUseCase(Params(query: tQuery)));
    });

    test('should emit [Initial, Loading, Error] when getting the data fails ', () async {
      // arrange
      when(mockSearchForWordsUseCase(any)).thenAnswer(
          (realInvocation) async => Left(NoLocalDictionaryFailure()));
      // assert later
      final expected = [
        SearchInitial(),
        SearchLoading(),
        SearchError(message: NO_LOCAL_DICTIONARY_ERROR)
      ];
      expectLater(searchBloc.state, emitsInOrder(expected));
      // act
      searchBloc.dispatch(GetSearchResults(query: tQuery));
    });


    test(
        'should emit [Initial, Loading, Loaded] when fetching the data is gotten from the local db successfully',
        () async {
          when(mockSearchForWordsUseCase(any)).thenAnswer(
                  (realInvocation) async => Right(result));
          // assert later
          final expected = [
            SearchInitial(),
            SearchLoading(),
            SearchLoaded(words: result)
          ];
          expectLater(searchBloc.state, emitsInOrder(expected));
          // act
          searchBloc.dispatch(GetSearchResults(query: tQuery));
    });
  });
}
