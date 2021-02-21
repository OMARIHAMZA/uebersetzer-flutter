import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/core/widgets/top_curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_results_screen.dart';
import 'package:uebersetzer/features/search/presentation/widgets/favorites_section.dart';
import 'package:uebersetzer/features/search/presentation/widgets/history_section.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_section_widget.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSearchSection(context),
        // Body
        TopCurvedWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // History Section
                HistorySection(),
                // Saved Words Section
                FavoritesSection(),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return SearchSectionWidget(onSubmitted: (value) {
      navigate(
        context,
        SearchResultsScreen(query: value),
      );
      // Save the query in the db
      BlocProvider.of<SearchHistoryBloc>(context)
          .dispatch(AddSearchRecordEvent(query: value));
    });
  }

  void _showSnackBar(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('in Bearbeitung')));
  }
}
