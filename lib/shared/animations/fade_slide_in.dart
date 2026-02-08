import 'package:flutter/material.dart';

class FadeSlideIn extends StatelessWidget {
  final Animation<double> anim;
  final Widget child;
  final double fromY;

  const FadeSlideIn({
    required this.anim,
    required this.child,
    required this.fromY,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final t = anim.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * fromY),
            child: child,
          ),
        );
      },
    );
  }
}