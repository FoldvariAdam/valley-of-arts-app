import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/widgets/app_bottom_bar_scroll_notification_listener.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BottomNavbarScrollNotificationListener(
        child: SafeArea(child: child),
      ),
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}
