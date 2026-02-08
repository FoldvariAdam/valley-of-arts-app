import 'package:flutter/material.dart';

class AppTokens {
  // --- Colors ---
  static const Color foregroundColor = Color(0xFFFFFFFF);

  //static const Color backgroundColor = Color(0xFF2F6B66);
  static const Color backgroundColor = Color(0xFF317E79);

  static const Color cardForegroundColor = Color(0xFFFFFFFF);
  static const Color cardBackgroundColor = Color(0xFF2A6E6A);

  static const Color primaryColor = Color(0xFFE24A6B);
  static const Color secondaryColor = Color(0xFFB52F63);

  static const Color borderColor = Color(0xFF5C8F8A);

  static const Color accentColor = Color(0xFFF2C23C);
  static const Color destructiveColor = Color(0xFFEB5757);

  static const Color mutedColor = Color(0xFF375E5B);
  static const Color mutedForegroundColor = Color(0xFF9EC6C3);

  static const Color selectedColor = Color(0xFF66875C);

  // --- Spacing ---
  static const double s0 = 5;
  static const double s1 = 10;
  static const double s2 = 15;
  static const double s3 = 20;
  static const double s4 = 25;

  // --- Radius ---
  static const double r2xl = 24;

  // --- Text styles ---
  static const TextStyle bigHeadLine = TextStyle(
    color: foregroundColor,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle mediumHeadLine = TextStyle(
    color: foregroundColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle smallHeadLine = TextStyle(
    color: foregroundColor,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle subTitle = TextStyle(
    color: AppTokens.mutedForegroundColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyText = TextStyle(
    color: foregroundColor,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle descriptionText = TextStyle(
    color: mutedForegroundColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
