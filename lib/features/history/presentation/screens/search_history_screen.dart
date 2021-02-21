import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/widgets/bottom_curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/core/widgets/top_curved_widget.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/history/presentation/widgets/history_list_item.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_field.dart';
import 'package:uebersetzer/main.dart';

class SearchHistoryScreen extends StatefulWidget {
  @override
  _SearchHistoryScreenState createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  SearchHistoryBloc historyBloc;

  @override
  void initState() {
    historyBloc = BlocProvider.of<SearchHistoryBloc>(context);
    historyBloc.dispatch(GetSearchHistoryEvent());
    super.initState();
  }

  @override
  void dispose() {
    historyBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context: context,),
      body: Column(
        children: [
          BottomCurvedWidget(
              child: SearchField(
            onSubmitted: (query) {},
          )),
          TopCurvedWidget(
            child: Column(
              children: [
                _blocBuilder(),
              ],
            ),
          )
        ],
      ),
    );
  }

  BlocBuilder<SearchHistoryBloc, SearchHistoryState> _blocBuilder() {
    return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
      builder: (context, state) {
        if (state is SearchHistoryInitial) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHistoryLoading) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHistoryLoaded) {
          return _buildHistoryListView(state);
        } else if (state is SearchHistoryEmpty) {
          return Text(getL10nInstance(context).noSearchHistory);
        } else if (state is SearchHistoryError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }

  Expanded _buildHistoryListView(SearchHistoryLoaded state) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return HistoryListItem(
              entry: state.history[index],
              onTileDismissed: () {
                historyBloc.dispatch(
                  DeleteSearchRecordEvent(id: state.history[index].id),
                );
              },
            );
          },
          separatorBuilder: (context, index) => Divider(
                indent: 0,
              ),
          itemCount: state.history.length),
    );
  }
}
