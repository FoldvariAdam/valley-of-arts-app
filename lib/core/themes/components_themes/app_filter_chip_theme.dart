import 'dart:ui';
import 'package:flutter/material.dart';

class AppFilterChipTheme extends ThemeExtension<AppFilterChipTheme> {
  final Color? backgroundColor;
  final Color? activeBackgroundColor;

  final Color? foregroundColor;
  final Color? activeForegroundColor;

  final Color? borderColor;
  final Color? activeBorderColor;

  final double? paddingHorizontal;
  final double? paddingVertical;

  final BorderRadius? borderRadius;
  final double? borderWidth;

  final double? iconSpacing;

  final Duration? scaleDuration;
  final Duration? containerDuration;
  final double? pressedScale;
  final Curve? curve;

  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;

  const AppFilterChipTheme({
    this.backgroundColor,
    this.activeBackgroundColor,
    this.foregroundColor,
    this.activeForegroundColor,
    this.borderColor,
    this.activeBorderColor,
    this.paddingHorizontal,
    this.paddingVertical,
    this.borderRadius,
    this.borderWidth,
    this.iconSpacing,
    this.scaleDuration,
    this.containerDuration,
    this.pressedScale,
    this.curve,
    this.textStyle,
    this.activeTextStyle,
  });

  @override
  AppFilterChipTheme copyWith({AppFilterChipTheme? theme}) {
    return AppFilterChipTheme(
      backgroundColor: theme?.backgroundColor ?? backgroundColor,
      activeBackgroundColor:
          theme?.activeBackgroundColor ?? activeBackgroundColor,
      foregroundColor: theme?.foregroundColor ?? foregroundColor,
      activeForegroundColor:
          theme?.activeForegroundColor ?? activeForegroundColor,
      borderColor: theme?.borderColor ?? borderColor,
      activeBorderColor: theme?.activeBorderColor ?? activeBorderColor,
      paddingHorizontal: theme?.paddingHorizontal ?? paddingHorizontal,
      paddingVertical: theme?.paddingVertical ?? paddingVertical,
      borderRadius: theme?.borderRadius ?? borderRadius,
      borderWidth: theme?.borderWidth ?? borderWidth,
      iconSpacing: theme?.iconSpacing ?? iconSpacing,
      scaleDuration: theme?.scaleDuration ?? scaleDuration,
      containerDuration: theme?.containerDuration ?? containerDuration,
      pressedScale: theme?.pressedScale ?? pressedScale,
      curve: theme?.curve ?? curve,
      textStyle: theme?.textStyle ?? textStyle,
      activeTextStyle: theme?.activeTextStyle ?? activeTextStyle,
    );
  }

  @override
  AppFilterChipTheme lerp(ThemeExtension<AppFilterChipTheme>? other, double t) {
    if (other is! AppFilterChipTheme) return this;

    return AppFilterChipTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeBackgroundColor: Color.lerp(
        activeBackgroundColor,
        other.activeBackgroundColor,
        t,
      )!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      activeForegroundColor: Color.lerp(
        activeForegroundColor,
        other.activeForegroundColor,
        t,
      )!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      activeBorderColor: Color.lerp(
        activeBorderColor,
        other.activeBorderColor,
        t,
      )!,
      paddingHorizontal: lerpDouble(
        paddingHorizontal,
        other.paddingHorizontal,
        t,
      )!,
      paddingVertical: lerpDouble(paddingVertical, other.paddingVertical, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t)!,
      scaleDuration: scaleDuration,
      containerDuration: containerDuration,
      pressedScale: lerpDouble(pressedScale, other.pressedScale, t)!,
      curve: curve,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      activeTextStyle: TextStyle.lerp(
        activeTextStyle,
        other.activeTextStyle,
        t,
      ),
    );
  }

  static AppFilterChipTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<AppFilterChipTheme>();

    assert(theme != null, 'AppFilterChipTheme is not registered in ThemeData');

    return theme!;
  }

  AppFilterChipTheme merge(AppFilterChipTheme? other) {
    if (other == null) return this;

    return AppFilterChipTheme(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      activeBackgroundColor: other.activeBackgroundColor??activeBackgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      activeForegroundColor: other.activeForegroundColor ?? activeForegroundColor,
      borderColor: other.borderColor ?? borderColor,
      activeBorderColor: other.activeBorderColor ?? activeBorderColor,
      paddingHorizontal: other.paddingHorizontal ?? paddingHorizontal,
      paddingVertical: other.paddingVertical ?? paddingVertical,
      borderRadius: other.borderRadius ?? borderRadius,
      borderWidth: other.borderWidth ?? borderWidth,
      iconSpacing: other.iconSpacing ?? iconSpacing,
      scaleDuration: other.scaleDuration ?? scaleDuration,
      containerDuration: other.containerDuration ?? containerDuration,
      pressedScale: other.pressedScale ?? pressedScale,
      curve: other.curve ?? curve,
      textStyle: other.textStyle ?? textStyle,
      activeTextStyle: other.activeTextStyle ?? activeTextStyle,
    );
  }
}
