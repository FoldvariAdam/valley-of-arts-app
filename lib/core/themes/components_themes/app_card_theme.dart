import 'dart:ui';
import 'package:flutter/material.dart';

class AppCardTheme extends ThemeExtension<AppCardTheme> {
  final Color? backgroundColor;
  final Color? pressedBackgroundColor;

  final Color? borderColor;
  final Color? pressedBorderColor;

  final Color? shadowColor;

  final double? borderWidth;
  final BorderRadius? borderRadius;

  final double? blurRadius;
  final double? pressedBlurRadius;
  final Offset? shadowOffset;

  final Duration? animationDuration;
  final double? pressedScale;
  final Curve? curve;

  final double? margin;
  final double? padding;

  const AppCardTheme({
    this.backgroundColor,
    this.pressedBackgroundColor,
    this.borderColor,
    this.pressedBorderColor,
    this.shadowColor,
    this.borderWidth,
    this.borderRadius,
    this.blurRadius,
    this.pressedBlurRadius,
    this.shadowOffset,
    this.animationDuration,
    this.pressedScale,
    this.curve,
    this.margin,
    this.padding,
  });

  @override
  AppCardTheme copyWith({AppCardTheme? theme}) {
    return AppCardTheme(
      backgroundColor: theme?.backgroundColor ?? backgroundColor,
      pressedBackgroundColor:
          theme?.pressedBackgroundColor ?? pressedBackgroundColor,
      borderColor: theme?.borderColor ?? borderColor,
      pressedBorderColor: theme?.pressedBorderColor ?? pressedBorderColor,
      shadowColor: theme?.shadowColor ?? shadowColor,
      borderWidth: theme?.borderWidth ?? borderWidth,
      borderRadius: theme?.borderRadius ?? borderRadius,
      blurRadius: theme?.blurRadius ?? blurRadius,
      pressedBlurRadius: theme?.pressedBlurRadius ?? pressedBlurRadius,
      shadowOffset: theme?.shadowOffset ?? shadowOffset,
      animationDuration: theme?.animationDuration ?? animationDuration,
      pressedScale: theme?.pressedScale ?? pressedScale,
      curve: theme?.curve ?? curve,
      margin: theme?.margin ?? margin,
      padding: theme?.padding ?? padding,
    );
  }

  @override
  AppCardTheme lerp(ThemeExtension<AppCardTheme>? other, double t) {
    if (other is! AppCardTheme) return this;

    return AppCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      pressedBackgroundColor: Color.lerp(
        pressedBackgroundColor,
        other.pressedBackgroundColor,
        t,
      )!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      pressedBorderColor: Color.lerp(
        pressedBorderColor,
        other.pressedBorderColor,
        t,
      )!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      blurRadius: lerpDouble(blurRadius, other.blurRadius, t)!,
      pressedBlurRadius: lerpDouble(
        pressedBlurRadius,
        other.pressedBlurRadius,
        t,
      )!,
      shadowOffset: Offset.lerp(shadowOffset, other.shadowOffset, t)!,
      animationDuration: animationDuration,
      pressedScale: lerpDouble(pressedScale, other.pressedScale, t)!,
      curve: curve,
      margin: margin,
      padding: padding,
    );
  }

  static AppCardTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<AppCardTheme>();

    assert(theme != null, 'AppCardTheme is not registered in ThemeData');

    return theme!;
  }

  AppCardTheme merge(AppCardTheme? other) {
    if (other == null) return this;

    return AppCardTheme(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      pressedBackgroundColor:
          other.pressedBackgroundColor ?? pressedBackgroundColor,
      borderColor: other.borderColor ?? borderColor,
      pressedBorderColor: other.pressedBorderColor ?? pressedBorderColor,
      shadowColor: other.shadowColor ?? shadowColor,
      borderWidth: other.borderWidth ?? borderWidth,
      borderRadius: other.borderRadius ?? borderRadius,
      blurRadius: other.blurRadius ?? blurRadius,
      pressedBlurRadius: other.pressedBlurRadius ?? pressedBlurRadius,
      shadowOffset: other.shadowOffset ?? shadowOffset,
      animationDuration: other.animationDuration ?? animationDuration,
      pressedScale: other.pressedScale ?? pressedScale,
      curve: other.curve ?? curve,
      margin: other.margin ?? margin,
      padding: other.padding ?? padding,
    );
  }
}
