import 'package:flutter/material.dart';

class AnimatedBrushStroke extends CustomPainter {
  final Animation<double> t1, t2, t3;

  AnimatedBrushStroke({
    required Listenable repaint,
    required this.t1,
    required this.t2,
    required this.t3,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final v1 = t1.value.clamp(0.0, 1.0);
    final v2 = t2.value.clamp(0.0, 1.0);
    final v3 = t3.value.clamp(0.0, 1.0);

    final sx = size.width / 400.0;
    final sy = size.height / 80.0;
    canvas.save();
    canvas.scale(sx, sy);

    _draw(canvas, _p1(), v1, const Color(0xFFF0C24B), 12);
    _draw(canvas, _p2(), v2, const Color(0xFFE23D8A), 10);
    _draw(canvas, _p3(), v3, const Color(0xFF2EDAD3), 6);

    canvas.restore();
  }

  void _draw(Canvas canvas, Path path, double t, Color color, double w) {
    final m = path.computeMetrics().first;
    final partial = m.extractPath(0, m.length * t);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color.withOpacity(t);

    canvas.drawPath(partial, paint);
  }

  Path _p1() => Path()
    ..moveTo(-20, 35)
    ..quadraticBezierTo(80, 15, 180, 40)
    ..quadraticBezierTo(280, 65, 380, 35)
    ..quadraticBezierTo(480, 5, 580, 40);

  Path _p2() => Path()
    ..moveTo(-40, 55)
    ..quadraticBezierTo(60, 30, 160, 55)
    ..quadraticBezierTo(260, 80, 360, 50)
    ..quadraticBezierTo(460, 20, 560, 55);

  Path _p3() => Path()
    ..moveTo(100, 25)
    ..quadraticBezierTo(150, 10, 200, 25);

  @override
  bool shouldRepaint(covariant AnimatedBrushStroke oldDelegate) => false;
}
