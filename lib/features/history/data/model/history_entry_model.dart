import 'package:flutter/foundation.dart';
import 'package:uebersetzer/core/database/database_helper.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';

const _ID_FIELD = DatabaseHelperImpl.commonColumnId;
const _QUERY_FIELD = DatabaseHelperImpl.historyColumnQuery;

class HistoryEntryModel extends HistoryEntry {
  HistoryEntryModel({@required int id, @required String query})
      : super(id: id, query: query);

  factory HistoryEntryModel.fromJson(Map<String, dynamic> json) =>
      HistoryEntryModel(id: json[_ID_FIELD], query: json[_QUERY_FIELD]);

  Map<String, dynamic> toJson() => {
        'id': id,
        'query': query,
      };

  static List<HistoryEntryModel> fromJsonList(
      List<Map<String, dynamic>> jsons) {
    List<HistoryEntryModel> result = [];
    for (var json in jsons) {
      result.add(HistoryEntryModel.fromJson(json));
    }
    return result;
  }
}
