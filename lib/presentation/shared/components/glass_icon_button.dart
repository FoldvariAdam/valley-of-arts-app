import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/themes/app_theme_factory.dart';
import 'package:valley_of_arts/presentation/shared/animations/animations.dart';

class GlassIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  final int delayMs;
  final double entranceFromX;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.active = false,
    this.delayMs = 0,
    this.entranceFromX = 0,
  });

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

class _GlassIconButtonState extends State<GlassIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final bg = _isPressed
        ? appTheme.primaryColor.withValues(alpha: 0.6)
        : widget.active
        ? appTheme.primaryColor
        : appTheme.componentBackgroundColor.withValues(alpha: 0.8);

    final fg = widget.active ? Colors.white : appTheme.foregroundColor;

    return Entrance(
      delayMs: widget.delayMs,
      fromX: widget.entranceFromX,
      duration: const Duration(milliseconds: 260),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.all(appTheme.s1),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: _isPressed
                  ? appTheme.primaryColor.withValues(alpha: 1.0)
                  : appTheme.borderColor.withValues(alpha: 0.5),
            ),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(widget.icon, color: fg, size: appTheme.s3),
        ),
      ),
    );
  }
}
