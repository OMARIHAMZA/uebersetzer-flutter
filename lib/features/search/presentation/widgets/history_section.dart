import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/presentation/widgets/section_title.dart';

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
          title: 'Suchverlauf',
          iconData: Icons.access_time_sharp,
          onPressed: () {},
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey[200],
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView.separated(
            itemCount: 0,
            separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
