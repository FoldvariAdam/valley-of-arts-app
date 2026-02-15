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

  // --- Content colors ---
  final Color mutedForegroundColor;
  final Color borderColor;

  // --- Surface colors ---
  final Color componentBackgroundColor;

  // --- Interaction colors ---
  final Color selectedColor;
  final Color highlightColor;

  // --- Text styles ---
  final TextStyle bigHeadLine;
  final TextStyle mediumHeadLine;
  final TextStyle smallHeadLine;

  final TextStyle subTitle;
  final TextStyle bodyText;
  final TextStyle descriptionText;
  final TextStyle metaText;

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
    required this.componentBackgroundColor,
    required this.borderColor,
    required this.mutedForegroundColor,
    required this.selectedColor,
    required this.highlightColor,
    required this.bigHeadLine,
    required this.mediumHeadLine,
    required this.smallHeadLine,
    required this.subTitle,
    required this.bodyText,
    required this.descriptionText,
    required this.metaText,
  });

  @override
  AppTheme copyWith() => this;

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) => this;
}
