import 'package:flutter/material.dart';
import 'package:uebersetzer/core/widgets/bottom_curved_widget.dart';
import 'package:uebersetzer/features/search/presentation/widgets/search/search_field.dart';

class SearchSectionWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;

  SearchSectionWidget({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return BottomCurvedWidget(
      child: SearchField(
        onSubmitted: onSubmitted,
      ),
    );
  }
}
