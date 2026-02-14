import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

enum AppButtonVariant { primary, secondary, ghost }
enum AppButtonIconPosition { leading, trailing }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final double? width;
  final AppButtonTheme? style;
  final Widget? icon;
  final AppButtonIconPosition iconPosition;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.style,
    this.icon,
    this.iconPosition = AppButtonIconPosition.leading,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.style,
    this.icon,
    this.iconPosition = AppButtonIconPosition.leading,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.style,
    this.icon,
    this.iconPosition = AppButtonIconPosition.leading,
  }) : variant = AppButtonVariant.ghost;

  @override
  Widget build(BuildContext context) {
    final baseTheme = context.appButtonTheme;
    final appButtonTheme = baseTheme.merge(style);

    ButtonStyle themeStyle;
    switch (variant) {
      case AppButtonVariant.primary:
        themeStyle = appButtonTheme.primary!;
        break;
      case AppButtonVariant.secondary:
        themeStyle = appButtonTheme.secondary!;
        break;
      case AppButtonVariant.ghost:
        themeStyle = appButtonTheme.ghost!;
        break;
    }

    Widget childContent = Text(text);

    if (icon != null) {
      childContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconPosition == AppButtonIconPosition.leading
            ? [icon!, const SizedBox(width: 8), Text(text)]
            : [Text(text), const SizedBox(width: 8), icon!],
      );
    }

    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: themeStyle,
        onPressed: onPressed,
        child: childContent,
      ),
    );
  }
}
