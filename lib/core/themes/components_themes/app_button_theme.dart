import 'package:flutter/material.dart';

class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  final ButtonStyle? primary;
  final ButtonStyle? secondary;
  final ButtonStyle? ghost;

  const AppButtonTheme({this.primary, this.secondary, this.ghost});

  @override
  AppButtonTheme copyWith({AppButtonTheme? theme}) {
    return AppButtonTheme(
      primary: theme?.primary ?? primary,
      secondary: theme?.secondary ?? secondary,
      ghost: theme?.ghost ?? ghost,
    );
  }

  @override
  AppButtonTheme lerp(ThemeExtension<AppButtonTheme>? other, double t) {
    if (other is! AppButtonTheme) return this;
    return AppButtonTheme(
      primary: ButtonStyle.lerp(primary, other.primary, t)!,
      secondary: ButtonStyle.lerp(secondary, other.secondary, t)!,
      ghost: ButtonStyle.lerp(ghost, other.ghost, t)!,
    );
  }

  static AppButtonTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<AppButtonTheme>();
    assert(theme != null, 'AppButtonTheme is not registered in ThemeData');
    return theme!;
  }

  AppButtonTheme merge(AppButtonTheme? other) {
    if (other == null) return this;

    return AppButtonTheme(
      primary: _mergeButtonStyle(primary, other.primary),
      secondary: _mergeButtonStyle(secondary, other.secondary),
      ghost: _mergeButtonStyle(ghost, other.ghost),
    );
  }

  ButtonStyle? _mergeButtonStyle(ButtonStyle? base, ButtonStyle? override) {
    if (base == null) return override;
    if (override == null) return base;

    return base.copyWith(
      backgroundColor: override.backgroundColor ?? base.backgroundColor,
      foregroundColor: override.foregroundColor ?? base.foregroundColor,
      padding: override.padding ?? base.padding,
      minimumSize: override.minimumSize ?? base.minimumSize,
      shape: override.shape ?? base.shape,
      side: override.side ?? base.side,
      overlayColor: override.overlayColor ?? base.overlayColor,
      shadowColor: override.shadowColor ?? base.shadowColor,
      elevation: override.elevation ?? base.elevation,
    );
  }
}
