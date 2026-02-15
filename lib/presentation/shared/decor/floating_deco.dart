import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:valley_of_arts/core/core.dart';

class FloatingDeco extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;

  const FloatingDeco({
    super.key,
    required this.assetPath,
    this.width = 60,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        appTheme.highlightColor.withValues(alpha: 0.5),
        BlendMode.srcIn,
      ),
    );
  }
}
