import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';
import 'package:uebersetzer/features/search/domain/repositories/search_repository.dart';
import 'package:uebersetzer/features/search/domain/use_cases/search_for_words_usecase.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  SearchForWordsUseCase usecase;
  MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    usecase =
        SearchForWordsUseCase(searchRepository: mockSearchRepository);
  });

  final tQuery = 'Arbeit';
  final tResult = [
    Word(
        word: tQuery,
        plural: 'Arbeiten',
        meaning: ['Work'],
        type: WordType.FEMININE)
  ];

  test('should fetch the results from the repository for the desired query',
      () async {
    // arrange
    when(mockSearchRepository.searchForWords(any))
        .thenAnswer((_) async => Right(tResult));
    // act
    final result = await usecase(Params(query: tQuery));
    // assert
    verify(mockSearchRepository.searchForWords(tQuery));
    expect(result, Right(tResult));
    verifyNoMoreInteractions(mockSearchRepository);
  });
}
