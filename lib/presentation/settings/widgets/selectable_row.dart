import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class SelectableRow extends StatelessWidget {
  final Widget? leading;
  final String title;
  final bool isSelected;
  final int index;
  final int length;

  const SelectableRow({
    super.key,
    required this.leading,
    required this.title,
    required this.isSelected,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    BorderRadius borderRadius;
    if (length == 1) {
      borderRadius = appTheme.r2xl;
    } else if (index == 0) {
      borderRadius = BorderRadius.vertical(
        top: Radius.circular(appTheme.r2xl.topLeft.x),
      );
    } else if (index == length - 1) {
      borderRadius = BorderRadius.vertical(
        bottom: Radius.circular(appTheme.r2xl.bottomLeft.x),
      );
    } else {
      borderRadius = BorderRadius.zero;
    }

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? appTheme.selectedColor : Colors.transparent,
        borderRadius: borderRadius,
      ),
      padding: EdgeInsets.all(appTheme.s2),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: appTheme.s1)],
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [Text(title, style: appTheme.bodyText)],
            ),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: isSelected ? 1 : 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.check, size: 20, color: appTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
