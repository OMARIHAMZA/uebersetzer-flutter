import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/utils/constants.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/core/widgets/top_curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_section_widget.dart';
import 'package:uebersetzer/features/search/presentation/widgets/words_list/words_list_view_widget.dart';
import 'package:uebersetzer/features/word_details/presentation/word_details_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  SearchResultsScreen({@required this.query});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  var appBarTitle;
  var query;

  @override
  void initState() {
    query = widget.query;
    _dispatchSearchEvent(query, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        mTitle: appBarTitle ?? query,
        mTextStyle: kNormalAppBarTextStyle,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SearchSectionWidget(
          onSubmitted: (value) {
            setState(() {
              query = value;
              appBarTitle = value;
            });
            BlocProvider.of<SearchBloc>(context)
                .dispatch(GetSearchResults(query: value));

            // Add the search query to the history table
            BlocProvider.of<SearchHistoryBloc>(context)
                .dispatch(AddSearchRecordEvent(query: query));
          },
        ),
        TopCurvedWidget(
            child: Container(
          width: double.infinity,
          child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Lokale Daten',
                      ),
                      Tab(
                        text: 'Duden',
                      ),
                      Tab(
                        text: 'Linguee',
                      ),
                      Tab(
                        text: 'Verbformen',
                      ),
                    ],
                  ),
                  _blocBuilder(context)
                ],
              )),
        )),
      ],
    );
  }

  Widget _blocBuilder(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return CircularProgressIndicator();
        } else if (state is SearchError) {
          return Text(state.message);
        } else if (state is SearchLoading) {
          return CircularProgressIndicator();
        } else if (state is SearchEmpty) {
          return Container();
        } else if (state is SearchLoaded) {
          return WordsListView(
            words: state.words,
            onTap: (wordTapped) async {
              await navigate(
                context,
                WordDetailsScreen(word: wordTapped),
              );
              _dispatchSearchEvent(query, context);
            },
          );
        } else {
          return Text('Unknown behavior!');
        }
      },
    );
  }

  void _dispatchSearchEvent(String query, BuildContext context) {
    // Dispatch Search Event
    BlocProvider.of<SearchBloc>(context)
        .dispatch(GetSearchResults(query: query));


  }

  @override
  void dispose() {
    super.dispose();
  }
}
