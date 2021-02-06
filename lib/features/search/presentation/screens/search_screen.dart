import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uebersetzer/core/utils/utils.dart';
import 'package:uebersetzer/core/widgets/curved_widget.dart';
import 'package:uebersetzer/core/widgets/my_app_bar_widget.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_results_screen.dart';
import 'package:uebersetzer/features/search/presentation/widgets/history_section.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_section_widget.dart';
import 'package:uebersetzer/features/search/presentation/widgets/section_title.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSearchSection(context),
        // Body
        CurvedWidget(
          child: Column(
            children: [
              // History Section
              HistorySection(),
              // Saved Words Section
              SectionTitle(
                  title: 'Gespeicherte Wörter',
                  iconData: Icons.star,
                  onPressed: () {
                    _showSnackBar(context);
                  }),
            ],
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
    });
  }

  void _showSnackBar(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('in Bearbeitung')));
  }
}
