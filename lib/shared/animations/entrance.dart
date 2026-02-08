import 'package:flutter/material.dart';

class Entrance extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final double fromX;
  final double fromY;
  final double fromScale;
  final Duration duration;
  final Curve curve;

  const Entrance({
    super.key,
    required this.child,
    this.delayMs = 0,
    this.fromX = 0,
    this.fromY = 0,
    this.fromScale = 1.0,
    this.duration = const Duration(milliseconds: 450),
    this.curve = Curves.easeOut,
  });

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _c, curve: widget.curve);

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final t = anim.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset((1 - t) * widget.fromX, (1 - t) * widget.fromY),
            child: Transform.scale(
              scale: widget.fromScale + (1 - widget.fromScale) * t,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
