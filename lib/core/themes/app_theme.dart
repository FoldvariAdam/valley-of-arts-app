import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  // --- Spacing ---
  final double s0, s1, s2, s3, s4, s5;

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
  final Color cardBackgroundColor;
  final Color borderColor;

  final Color selectedColor;

  // --- Text styles ---
  final TextStyle bigHeadLine;
  final TextStyle mediumHeadLine;
  final TextStyle smallHeadLine;

  final TextStyle subTitle;
  final TextStyle bodyText;
  final TextStyle descriptionText;

  const AppTheme({
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.r2xl,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.destructiveColor,
    required this.cardBackgroundColor,
    required this.borderColor,
    required this.mutedColor,
    required this.mutedForegroundColor,
    required this.selectedColor,
    required this.bigHeadLine,
    required this.mediumHeadLine,
    required this.smallHeadLine,
    required this.subTitle,
    required this.bodyText,
    required this.descriptionText,
  });

  @override
  AppTheme copyWith() => this;

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) => this;
}
