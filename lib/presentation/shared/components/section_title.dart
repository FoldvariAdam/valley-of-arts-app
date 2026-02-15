import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: appTheme.highlightColor),
        SizedBox(width: appTheme.s1),
        Text(title, style: appTheme.smallHeadLine),
      ],
    );
  }
}
