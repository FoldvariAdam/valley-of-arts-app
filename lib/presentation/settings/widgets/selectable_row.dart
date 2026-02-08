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
    Color selectedColor = Color.lerp(
      Color(0xFF2A6E6A),
      Color(0xFFF2C23C),
      0.3,
    )!;

    final bg = isSelected ? selectedColor : Colors.transparent;

    return Container(
      color: bg,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: appTheme.foregroundColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: isSelected ? 1 : 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.check, size: 24, color: appTheme.accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
