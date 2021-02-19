import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoLocalDictionaryFailure extends Failure {}

class DatabaseFailure extends Failure {
  final String message;

  DatabaseFailure({@required this.message});

  @override
  List get props => [message];
}
