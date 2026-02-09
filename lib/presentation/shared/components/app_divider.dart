import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Divider(height: 1, thickness: 1, color: appTheme.borderColor);
  }
}
