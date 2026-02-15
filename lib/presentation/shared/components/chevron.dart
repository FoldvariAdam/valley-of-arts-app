import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class ChevronRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leadingIcon;

  const ChevronRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Row(
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          SizedBox(width: appTheme.s2),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: appTheme.bodyText),
              if (subtitle != null) ...[
                SizedBox(height: appTheme.s0),
                Text(
                  subtitle!,
                  style: appTheme.descriptionText,
                ),
              ],
            ],
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: 22,
          color: appTheme.foregroundColor,
        ),
      ],
    );
  }
}
