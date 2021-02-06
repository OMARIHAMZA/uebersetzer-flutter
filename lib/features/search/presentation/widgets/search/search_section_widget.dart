import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_field.dart';

class SearchSectionWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;

  SearchSectionWidget({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              BorderRadius.only(bottomLeft: const Radius.circular(30)),
          border: Border.all(color: Theme.of(context).primaryColor, width: 0)),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: SearchField(
        onSubmitted: onSubmitted,
      ),
    );
  }
}
