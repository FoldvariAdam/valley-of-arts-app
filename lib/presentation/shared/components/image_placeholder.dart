import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [appTheme.primaryColor, appTheme.backgroundColor],
        ),
      ),
    );
  }
}
