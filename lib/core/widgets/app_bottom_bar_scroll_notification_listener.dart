import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/nav_bar_controller.dart';

class NoDisappearBottomNavbarKey extends UniqueKey {}

class BottomNavbarScrollNotificationListener extends StatelessWidget {
  final Widget child;

  BottomNavbarScrollNotificationListener({
    super.key,
    required this.child,
  });

  final NavBarController _navBarController = GetIt.instance.get<NavBarController>();

  // 120 is the least minimum threshold
  final double _minimumScrollThreshold = 120;

  @override
  Widget build(BuildContext context) {
    double totalScrollOffset = 0;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // Do nothing on horizontal scrolls
        if (notification.metrics.axis == Axis.horizontal || notification is! ScrollUpdateNotification) {
          return true;
        }

        final element = notification.context as Element;

        final Widget? widget = element.findAncestorWidgetOfExactType<SingleChildScrollView>() ??
            element.findAncestorWidgetOfExactType<ListView>() ??
            element.findAncestorWidgetOfExactType<CustomScrollView>() ??
            element.findAncestorWidgetOfExactType<GridView>();

        final currentKey = widget?.key;
        if (currentKey is NoDisappearBottomNavbarKey) {
          return true;
        }

        // If the user reached the top of the screen, furthermore scrolling like PullToRefreshContainer won't affect the bottom bar
        if (notification.metrics.pixels <= 0) {
          return true;
        }

        totalScrollOffset += notification.scrollDelta ?? 0;

        if (totalScrollOffset >= _minimumScrollThreshold) {
          _navBarController.close();
          totalScrollOffset = 0;
        }

        if (totalScrollOffset <= -20) {
          _navBarController.open();
          totalScrollOffset = 0;
        }

        return true;
      },
      child: child,
    );
  }
}