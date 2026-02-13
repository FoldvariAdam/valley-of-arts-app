import 'package:flutter/material.dart';

class AnimatedCircle extends StatelessWidget {
  final Animation<double> anim;
  final double size;
  final Color color;
  final double opacity;
  final double? left, right, top, bottom;

  const AnimatedCircle({
    super.key,
    required this.anim,
    required this.size,
    required this.color,
    required this.opacity,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: ScaleTransition(
        scale: anim,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
