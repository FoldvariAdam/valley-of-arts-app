import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final hasSubtitle = subtitle != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showBackButton) ...[
          const AppBackButton(),
          SizedBox(width: appTheme.s2),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: appTheme.mediumHeadLine),
              if (hasSubtitle) ...[
                SizedBox(height: appTheme.s0),
                Text(subtitle!, style: appTheme.subTitle),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
