import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uebersetzer/core/utils/constants.dart';
import 'package:uebersetzer/core/widgets/curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_section_widget.dart';
import 'package:uebersetzer/features/search/presentation/widgets/words_list/words_list_view_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  SearchResultsScreen({@required this.query});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  var appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        mTitle: appBarTitle ?? widget.query,
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
              appBarTitle = value;
            });
            BlocProvider.of<SearchBloc>(context)
                .dispatch(GetSearchResults(query: value));
          },
        ),
        CurvedWidget(
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
                  SizedBox(
                    height: 10,
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
          _dispatchSearchEvent(widget.query, context);
          return CircularProgressIndicator();
        } else if (state is SearchError) {
          return Text(state.message);
        } else if (state is SearchLoading) {
          return CircularProgressIndicator();
        } else if (state is SearchLoaded) {
          return WordsListView(words: state.words);
        } else {
          return Text('Unknown behavior!');
        }
      },
    );
  }

  void _dispatchSearchEvent(String query, BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .dispatch(GetSearchResults(query: query));
  }
}
