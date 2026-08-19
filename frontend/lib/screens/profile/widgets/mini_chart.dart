import 'dart:math' as math;

import 'package:flutter/material.dart';

class MiniChart extends StatelessWidget {
  final Color color;
  final double size;

  const MiniChart({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: MiniChartPainter(color: color)),
    );
  }
}

class MiniChartPainter extends CustomPainter {
  final Color color;

  MiniChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.shortestSide / 2 - 2;

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * .68, paint);

    for (int i = 0; i < 12; i++) {
      final angle = i * 30 * math.pi / 180;

      final outer = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final inner = Offset(
        center.dx + radius * .68 * math.cos(angle),
        center.dy + radius * .68 * math.sin(angle),
      );

      canvas.drawLine(inner, outer, paint);
    }

    canvas.drawLine(
      Offset(center.dx - radius * .6, center.dy),
      Offset(center.dx + radius * .5, center.dy - radius * .4),
      paint,
    );

    canvas.drawLine(
      Offset(center.dx, center.dy - radius * .6),
      Offset(center.dx + radius * .5, center.dy + radius * .5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant MiniChartPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
