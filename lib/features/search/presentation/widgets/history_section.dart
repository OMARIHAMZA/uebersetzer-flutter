import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/navigation/bottom_navigation.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/history/presentation/widgets/history_list_item.dart';
import 'package:uebersetzer/features/search/presentation/widgets/section_title.dart';
import 'package:uebersetzer/main.dart';

class HistorySection extends StatefulWidget {
  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: getL10nInstance(context).history,
          iconData: Icons.access_time_sharp,
          onPressed: () {
            BottomNavigationBar bottomNavBar = bottomGlobalKey.currentWidget;
            bottomNavBar.onTap(2);
          },
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey[200],
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
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
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      state.history.length > 5 ? 5 : state.history.length,
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return HistoryListItem(
                        entry: state.history[index], onTileDismissed: (){
                          BlocProvider.of<SearchHistoryBloc>(context).dispatch(DeleteSearchRecordEvent(id: state.history[index].id));
                    });
                  },
                );
              } else if (state is SearchHistoryEmpty) {}
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
