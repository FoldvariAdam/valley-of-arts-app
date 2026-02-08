import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class SelectableRow extends StatelessWidget {
  final Widget? leading;
  final String title;
  final bool isSelected;

  const SelectableRow({
    super.key,
    required this.leading,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final bg = isSelected ? appTheme.selectedColor : Colors.transparent;

    return Container(
      color: bg,
      padding: EdgeInsets.all(appTheme.s2),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: appTheme.s1)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: appTheme.bodyText
                )
              ],
            ),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: isSelected ? 1 : 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.check, size: 24, color: appTheme.accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
