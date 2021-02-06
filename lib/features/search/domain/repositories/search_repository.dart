import 'package:dartz/dartz.dart';
import 'package:uebersetzer/core/errors/failures.dart';
import 'package:uebersetzer/features/search/domain/entites/word.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Word>>> searchForWords(String query);
}