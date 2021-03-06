import 'package:flutter/material.dart';
import 'package:uebersetzer/features/favorites/presentation/screens/FavoritesScreen.dart';
import 'package:uebersetzer/features/history/presentation/screens/search_history_screen.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_screen.dart';
import 'package:uebersetzer/features/settings/presentation/screen/settings_screen.dart';

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
        builder: (context) {
          switch (flow.screenId) {
            case ScreenId.SEARCH_SCREEN:
              return SearchScreen();

            case ScreenId.FAVORITES_SCREEN:
              return FavoritesScreen();

            case ScreenId.HISTORY_SCREEN:
              return SearchHistoryScreen();

            case ScreenId.SETTINGS_SCREEN:
              return SettingsScreen();
          }
          return SearchScreen();
        },
      ),
    );
  }
}
