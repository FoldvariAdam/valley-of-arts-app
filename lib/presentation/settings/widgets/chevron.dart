import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class ChevronRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ChevronRow({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: appTheme.bodyText,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 22,
                  color: appTheme.foregroundColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
