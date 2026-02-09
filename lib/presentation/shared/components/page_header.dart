import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/animations/animations.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Entrance(
      fromY: -20,
      delayMs: 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: appTheme.mediumHeadLine,
            ),
            if (subtitle != null) ...[
              SizedBox(height: appTheme.s0),
              Text(
                subtitle!,
                style: appTheme.subTitle,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
