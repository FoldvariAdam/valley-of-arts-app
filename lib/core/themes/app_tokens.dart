import 'package:flutter/material.dart';

class AppTokens {
  // --- Colors ---
  static const Color foregroundColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFF317E79);

  static const Color primaryColor = Color(0xFFE24A6B);
  static const Color secondaryColor = Color(0xFFB52F63);

  static const Color mutedForegroundColor = Color(0xFF9EC6C3);
  static const Color borderColor = Color(0xFF5C8F8A);

  static const Color componentBackgroundColor = Color(0xFF2A6E6A);

  static const Color selectedColor = Color(0xFFF5A3B2);
  static const Color highlightColor = Color(0xFF6EDBE0);

  // --- Spacing ---
  static const double s0 = 5;
  static const double s1 = 10;
  static const double s2 = 15;
  static const double s3 = 20;
  static const double s4 = 25;
  static const double s5 = 30;

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

  static const TextStyle metaText = TextStyle(
    color: foregroundColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
