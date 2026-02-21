import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class AppFilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final String? icon;
  final AppFilterChipTheme? style;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.icon,
    this.style,
  });

  @override
  State<AppFilterChip> createState() => _AppFilterChipState();
}

class _AppFilterChipState extends State<AppFilterChip> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final baseTheme = context.appFilterChipTheme;
    final appFilterChip = baseTheme.merge(widget.style);

    final bg = widget.isActive
        ? appFilterChip.activeBackgroundColor!
        : appFilterChip.backgroundColor!;

    final border = widget.isActive
        ? appFilterChip.activeBorderColor!
        : appFilterChip.borderColor!;

    final textStyle = widget.isActive
        ? appFilterChip.activeTextStyle!
        : appFilterChip.textStyle!;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        duration: appFilterChip.scaleDuration!,
        curve: appFilterChip.curve!,
        scale: _down ? appFilterChip.pressedScale! : 1.0,
        child: AnimatedContainer(
          duration: appFilterChip.containerDuration!,
          curve: appFilterChip.curve!,
          padding: EdgeInsets.symmetric(
            horizontal: appFilterChip.paddingHorizontal!,
            vertical: appFilterChip.paddingVertical!,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: appFilterChip.borderRadius,
            border: Border.all(
              color: border,
              width: appFilterChip.borderWidth!,
            ),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              if (widget.icon != null) ...[
                Text(widget.icon!, style: textStyle),
                SizedBox(width: appFilterChip.iconSpacing),
              ],
              Text(widget.label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
