import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/decor/decor.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppEmptyState({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            const FloatingDeco(
              assetPath: 'assets/mask.svg',
              width: 75,
              height: 75,
            ),

            SizedBox(height: appTheme.s2),

            Text(
              title,
              style: TextStyle(
                color: appTheme.foregroundColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),

            SizedBox(height: appTheme.s1),

            Text(
              subtitle,
              style: TextStyle(
                color: appTheme.mutedForegroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
