import 'package:flutter/material.dart';
import 'package:uebersetzer/features/favorites/presentation/screens/FavoritesScreen.dart';
import 'package:uebersetzer/features/search/presentation/screens/search_screen.dart';

enum ScreenId {
  SEARCH_SCREEN,
  FAVORITES_SCREEN,
  HISTORY_SCREEN,
  SETTINGS_SCREEN
}

class AppFlow {
  final String title;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final ScreenId screenId;

  AppFlow(
      {@required this.title,
      @required this.iconData,
      @required this.navigatorKey,
      @required this.screenId});
}

