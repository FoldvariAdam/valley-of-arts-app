import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class AppFilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final String? icon;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.icon,
  });

  @override
  State<AppFilterChip> createState() => _AppFilterChipState();
}

class _AppFilterChipState extends State<AppFilterChip> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final bg = widget.isActive
        ? appTheme.primaryColor
        : appTheme.cardBackgroundColor;
    final fg = widget.isActive
        ? appTheme.accentColor
        : appTheme.foregroundColor;
    final border = widget.isActive
        ? appTheme.primaryColor
        : appTheme.borderColor;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        scale: _down ? 0.95 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: appTheme.s2,
            vertical: appTheme.s1,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Text(widget.icon!, style: TextStyle(color: fg)),

                SizedBox(width: appTheme.s0),
              ],
              Text(widget.label, style: appTheme.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
