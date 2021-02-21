import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uebersetzer/core/navigation/app_flow.dart';
import 'package:uebersetzer/core/navigation/bottom_navigation.dart';
import 'package:uebersetzer/core/widgets/animated_indexed_stack.dart';
import 'package:uebersetzer/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:uebersetzer/features/history/presentation/bloc/search_history_bloc.dart';
import 'package:uebersetzer/features/search/presentation/bloc/search_bloc.dart';
import 'package:uebersetzer/main.dart';

import 'core/navigation/tab_navigator.dart';
import 'injection_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppFlow> appFlows;
  int _currentBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    _buildAppFlows(context);
    final currentFlow = appFlows[_currentBarIndex];
    return WillPopScope(
      onWillPop: () async => !await appFlows[_currentBarIndex]
          .navigatorKey
          .currentState
          .maybePop(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(builder: (context) => sl<SearchBloc>()),
          BlocProvider<FavoritesBloc>(
              builder: (context) => sl<FavoritesBloc>()),
          BlocProvider<SearchHistoryBloc>(
              builder: (context) => sl<SearchHistoryBloc>())
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FadeIndexedStack(
            index: _currentBarIndex,
            children: appFlows.map((flow) => TabNavigator(flow: flow)).toList(),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
              appFlows: appFlows,
              currentBarIndex: _currentBarIndex,
              onTap: (newIndex) => setState(() {
                    if (_currentBarIndex != newIndex) {
                      _currentBarIndex = newIndex;
                    } else {
                      currentFlow.navigatorKey.currentState
                          .popUntil((route) => route.isFirst);
                    }
                  })),
        ),
      ),
    );
  }

  void _buildAppFlows(BuildContext context) {
    appFlows = [
      AppFlow(
          title: getL10nInstance(context).search,
          iconData: Icons.home_outlined,
          navigatorKey: GlobalKey<NavigatorState>(),
          screenId: ScreenId.SEARCH_SCREEN),
      AppFlow(
          title: getL10nInstance(context).favorites,
          iconData: Icons.star_border_outlined,
          navigatorKey: GlobalKey<NavigatorState>(),
          screenId: ScreenId.FAVORITES_SCREEN),
      AppFlow(
          title: getL10nInstance(context).history,
          iconData: Icons.history,
          navigatorKey: GlobalKey<NavigatorState>(),
          screenId: ScreenId.HISTORY_SCREEN),
      AppFlow(
          title: getL10nInstance(context).settings,
          iconData: Icons.settings,
          navigatorKey: GlobalKey<NavigatorState>(),
          screenId: ScreenId.SETTINGS_SCREEN),
    ];
  }
}
