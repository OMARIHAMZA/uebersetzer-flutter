import 'package:flutter/material.dart';

class AppFlow {
  final String title;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;

  AppFlow({
    @required this.title,
    @required this.iconData,
    @required this.navigatorKey,
  });
}

final List<AppFlow> appFlows = [
  AppFlow(
      title: 'Search',
      iconData: Icons.home_outlined,
      navigatorKey: GlobalKey<NavigatorState>()),
  AppFlow(
      title: 'Gespeichert',
      iconData: Icons.star_border_outlined,
      navigatorKey: GlobalKey<NavigatorState>()),
  AppFlow(
      title: 'Verlauf',
      iconData: Icons.history,
      navigatorKey: GlobalKey<NavigatorState>()),
  AppFlow(
      title: 'Einst.',
      iconData: Icons.settings,
      navigatorKey: GlobalKey<NavigatorState>()),
];
