import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

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
      surface: AppTokens.componentBackgroundColor,
      onSurface: AppTokens.foregroundColor,
      surfaceContainerHighest: AppTokens.componentBackgroundColor,
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
        color: AppTokens.componentBackgroundColor,
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
        fillColor: AppTokens.componentBackgroundColor,
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
          componentBackgroundColor: AppTokens.componentBackgroundColor,
          borderColor: AppTokens.borderColor,
          mutedForegroundColor: AppTokens.mutedForegroundColor,
          selectedColor: AppTokens.selectedColor,
          highlightColor: AppTokens.highlightColor,
          bigHeadLine: AppTokens.bigHeadLine,
          mediumHeadLine: AppTokens.mediumHeadLine,
          smallHeadLine: AppTokens.smallHeadLine,
          subTitle: AppTokens.subTitle,
          bodyText: AppTokens.bodyText,
          descriptionText: AppTokens.descriptionText,
          metaText: AppTokens.metaText,
        ),
        AppCardTheme(
          backgroundColor: AppTokens.componentBackgroundColor,
          pressedBackgroundColor: AppTokens.primaryColor,
          borderColor: AppTokens.borderColor,
          pressedBorderColor: AppTokens.primaryColor,
          shadowColor: Colors.black,
          borderWidth: 1.2,
          borderRadius: BorderRadius.circular(AppTokens.r2xl),
          blurRadius: 16,
          pressedBlurRadius: 22,
          shadowOffset: const Offset(0, 10),
          animationDuration: const Duration(milliseconds: 150),
          pressedScale: 0.96,
          curve: Curves.easeOut,
          margin: AppTokens.s0,
          padding: AppTokens.s2,
        ),
        AppFilterChipTheme(
          backgroundColor: AppTokens.componentBackgroundColor,
          activeBackgroundColor: AppTokens.primaryColor,
          foregroundColor: AppTokens.foregroundColor,
          activeForegroundColor: AppTokens.foregroundColor,
          borderColor: AppTokens.borderColor,
          activeBorderColor: AppTokens.primaryColor,
          paddingHorizontal: AppTokens.s2,
          paddingVertical: AppTokens.s1,
          borderRadius: BorderRadius.circular(999),
          borderWidth: 1.0,
          iconSpacing: AppTokens.s0,
          scaleDuration: const Duration(milliseconds: 120),
          containerDuration: const Duration(milliseconds: 150),
          pressedScale: 0.95,
          curve: Curves.easeOut,
          textStyle: AppTokens.bodyText,
          activeTextStyle: AppTokens.bodyText,
        ),
        AppButtonTheme(
          primary: ElevatedButton.styleFrom(
            backgroundColor: AppTokens.primaryColor,
            foregroundColor: AppTokens.foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTokens.r2xl),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            minimumSize: const Size(64, 56),
          ),
          secondary: ElevatedButton.styleFrom(
            backgroundColor: AppTokens.secondaryColor,
            foregroundColor: AppTokens.foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTokens.r2xl),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            minimumSize: const Size(64, 40),
          ),
          ghost: ElevatedButton.styleFrom(
            backgroundColor: AppTokens.selectedColor,
            foregroundColor: AppTokens.foregroundColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            minimumSize: const Size(64, 40),
            side: const BorderSide(
              color: AppTokens.selectedColor,
              width: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

extension AppStyleX on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
}

extension AppCardStyleX on BuildContext {
  AppCardTheme get appCardTheme => Theme.of(this).extension<AppCardTheme>()!;
}

extension AppFilterChipStyleX on BuildContext {
  AppFilterChipTheme get appFilterChipTheme =>
      Theme.of(this).extension<AppFilterChipTheme>()!;
}

extension AppButtonThemeStyleX on BuildContext {
  AppButtonTheme get appButtonTheme =>
      Theme.of(this).extension<AppButtonTheme>()!;
}
