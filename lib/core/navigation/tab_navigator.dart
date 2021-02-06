import 'package:flutter/material.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_results_screen.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_screen.dart';

import 'app_flow.dart';

class TabNavigator extends StatelessWidget {
  final AppFlow flow;

  TabNavigator({@required this.flow});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: flow.navigatorKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SearchScreen(),
      ),
    );
  }
}
