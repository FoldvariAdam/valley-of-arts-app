import 'package:flutter/material.dart';
import 'package:valley_of_arts/presentation/shared/decor/decor.dart';

class ProgramsDeco extends StatelessWidget {
  const ProgramsDeco({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO ADD FILE PATH TO APP THEME
    return Stack(
      children: [
        Positioned(
          top: 140,
          left: 30,
          child: Transform.rotate(
            angle: -0.8,
            child: const FloatingDeco(
              assetPath: 'assets/drama-masks.svg',
              width: 75,
              height: 75,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Transform.rotate(
            angle: 0.4,
            child: const FloatingDeco(
              assetPath: 'assets/joker-hat.svg',
              width: 60,
              height: 60,
            ),
          ),
        ),
        /*Positioned(
          top: 360,
          right: 45,
          child: Transform.rotate(
            angle: 0.2,
            child: const FloatingDeco(
              assetPath: 'assets/mask.svg',
              width: 75,
              height: 75,
            ),
          ),
        ),
        const Positioned(
          top: 575,
          left: 30,
          child: FloatingDeco(
            assetPath: 'assets/tent.svg',
            width: 50,
            height: 50,
          ),
        ),*/
      ],
    );
  }
}
