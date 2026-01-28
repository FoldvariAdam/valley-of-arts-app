import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  // --- Spacing ---
  final double s0, s1, s2, s3, s4;

  // --- Radius ---
  final BorderRadius r2xl;

  // --- Base colors ---
  final Color foregroundColor;
  final Color backgroundColor;

  // --- Semantic colors ---
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color destructiveColor;
  final Color mutedColor;
  final Color mutedForegroundColor;

  // --- Surface colors ---
  final Color cardColor;
  final Color borderColor;

  const AppTheme({
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.r2xl,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.destructiveColor,
    required this.cardColor,
    required this.borderColor,
    required this.mutedColor,
    required this.mutedForegroundColor,
  });

  @override
  AppTheme copyWith({
    double? s0,
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    BorderRadius? r2xl,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? destructiveColor,
    Color? cardColor,
    Color? borderColor,
    Color? mutedColor,
    Color? mutedForegroundColor,
  }) {
    return AppTheme(
      s0: s0 ?? this.s0,
      s1: s1 ?? this.s1,
      s2: s2 ?? this.s2,
      s3: s3 ?? this.s3,
      s4: s4 ?? this.s4,
      r2xl: r2xl ?? this.r2xl,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      destructiveColor: destructiveColor ?? this.destructiveColor,
      cardColor: cardColor ?? this.cardColor,
      borderColor: borderColor ?? this.borderColor,
      mutedColor: mutedColor ?? this.mutedColor,
      mutedForegroundColor: mutedForegroundColor ?? this.mutedForegroundColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    return AppTheme(
      s0: lerpDouble(s0, other.s0, t) ?? s0,
      s1: lerpDouble(s1, other.s1, t) ?? s1,
      s2: lerpDouble(s2, other.s2, t) ?? s2,
      s3: lerpDouble(s3, other.s3, t) ?? s3,
      s4: lerpDouble(s4, other.s4, t) ?? s4,
      r2xl: BorderRadius.lerp(r2xl, other.r2xl, t) ?? r2xl,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t) ?? secondaryColor,
      accentColor: Color.lerp(accentColor, other.accentColor, t) ?? accentColor,
      destructiveColor: Color.lerp(destructiveColor, other.destructiveColor, t) ?? destructiveColor,
      cardColor: Color.lerp(cardColor, other.cardColor, t) ?? cardColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      mutedColor: Color.lerp(mutedColor, other.mutedColor, t) ?? mutedColor,
      mutedForegroundColor: Color.lerp(mutedForegroundColor, other.mutedForegroundColor, t) ?? mutedForegroundColor,
    );
  }
}
