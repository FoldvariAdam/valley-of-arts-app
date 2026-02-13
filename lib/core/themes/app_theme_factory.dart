import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/themes/app_theme.dart';
import 'package:valley_of_arts/core/themes/app_tokens.dart';

class AppThemeFactory {
  AppThemeFactory._();

  static ThemeData create() {
    /// TODO: test all the colors
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppTokens.primaryColor,
      onPrimary: AppTokens.foregroundColor,
      secondary: AppTokens.secondaryColor,
      onSecondary: AppTokens.foregroundColor,
      error: Colors.red,
      onError: AppTokens.foregroundColor,
      surface: AppTokens.cardBackgroundColor,
      onSurface: AppTokens.foregroundColor,
      surfaceContainerHighest: AppTokens.cardBackgroundColor,
      onSurfaceVariant: AppTokens.foregroundColor.withValues(alpha: 0.75),
      outline: AppTokens.borderColor,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppTokens.backgroundColor,
    );

    return base.copyWith(
      cardTheme: CardThemeData(
        color: AppTokens.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r2xl),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.primaryColor,
          foregroundColor: AppTokens.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.r2xl),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTokens.cardBackgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.r2xl),
          borderSide: const BorderSide(color: AppTokens.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.r2xl),
          borderSide: const BorderSide(color: AppTokens.primaryColor),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppTheme(
          s0: AppTokens.s0,
          s1: AppTokens.s1,
          s2: AppTokens.s2,
          s3: AppTokens.s3,
          s4: AppTokens.s4,
          s5: AppTokens.s5,
          r2xl: BorderRadius.circular(AppTokens.r2xl),
          foregroundColor: AppTokens.foregroundColor,
          backgroundColor: AppTokens.backgroundColor,
          primaryColor: AppTokens.primaryColor,
          secondaryColor: AppTokens.secondaryColor,
          accentColor: AppTokens.accentColor,
          destructiveColor: AppTokens.destructiveColor,
          cardBackgroundColor: AppTokens.cardBackgroundColor,
          borderColor: AppTokens.borderColor,
          mutedForegroundColor: AppTokens.mutedForegroundColor,
          mutedColor: AppTokens.mutedColor,
          selectedColor: AppTokens.selectedColor,
          bigHeadLine: AppTokens.bigHeadLine,
          mediumHeadLine: AppTokens.mediumHeadLine,
          smallHeadLine: AppTokens.smallHeadLine,
          subTitle: AppTokens.subTitle,
          bodyText: AppTokens.bodyText,
          descriptionText: AppTokens.descriptionText,
        ),
      ],
    );
  }
}

extension AppStyleX on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
}
