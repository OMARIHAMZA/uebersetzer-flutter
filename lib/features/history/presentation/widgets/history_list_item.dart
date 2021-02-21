import 'package:flutter/material.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/features/history/domain/entities/history_entry.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_results_screen.dart';

class HistoryListItem extends StatelessWidget {
  final HistoryEntry entry;
  final Function onTileDismissed;

  HistoryListItem({@required this.entry, @required this.onTileDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(entry.id),
      onDismissed: (direction) => onTileDismissed(),
      child: ListTile(
        title: Text(
          entry.query,
          style: TextStyle(color: Colors.grey[600]),
        ),
        leading: Icon(
          Icons.history,
          color: Colors.grey[600],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[600],
        ),
        onTap: () {
          navigate(
            context,
            SearchResultsScreen(query: entry.query),
          );
        },
      ),
    );
  }
}
