import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HistoryEntry extends Equatable {
  final int id;
  final String query;

  HistoryEntry({@required this.id, @required this.query});

  @override
  List get props => [id, query];
}
