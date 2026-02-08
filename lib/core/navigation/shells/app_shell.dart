import 'package:flutter/material.dart';
import 'package:valley_of_arts/shared/shared.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: child),
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}
