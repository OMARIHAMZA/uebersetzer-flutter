import 'package:flutter/material.dart';

import 'app_flow.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentBarIndex;
  final ValueChanged<int> onTap;

  AppBottomNavigationBar({
    @required this.currentBarIndex,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentBarIndex,
      items: appFlows
          .map((flow) => BottomNavigationBarItem(
                icon: Icon(flow.iconData),
                label: flow.title,
              ))
          .toList(),
      onTap: onTap,
    );
  }
}
