import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';

class ChartWheelCard extends StatelessWidget {
  final NatalChartModel data;
  final Color accentColor;
  final ChartLayout layout;

  const ChartWheelCard({
    super.key,
    required this.data,
    required this.accentColor,
    required this.layout,
  });

  bool get isMobile => layout == ChartLayout.mobile;

  bool get isTablet => layout == ChartLayout.tablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 14 : (isTablet ? 22 : 28),
        isMobile ? 18 : 24,
        isMobile ? 14 : (isTablet ? 22 : 28),
        isMobile ? 20 : 28,
      ),
      decoration: cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.celestialBlueprintTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accentColor,
              fontFamily: 'serif',
              fontSize: isMobile ? 20 : (isTablet ? 23 : 26),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final available = constraints.maxWidth;

              double chartSize;

              if (isMobile) {
                chartSize = math.min(available, 350);
              } else if (isTablet) {
                chartSize = math.min(available * .76, 500);
              } else {
                chartSize = math.min(available * .78, 560);
              }

              return Center(
                child: SizedBox(
                  width: chartSize,
                  height: chartSize,
                  child: CustomPaint(
                    painter: NatalWheelPainter(
                      houses: data.chart.houses,
                      planets: data.chart.planets,
                      aspects: data.chart.aspects,
                      accentColor: accentColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NatalWheelPainter extends CustomPainter {
  final List<ChartHouse> houses;
  final List<ChartPlanet> planets;
  final List<ChartAspect> aspects;
  final Color accentColor;

  NatalWheelPainter({
    required this.houses,
    required this.planets,
    required this.aspects,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = math.max(10, size.shortestSide / 2 - 17);

    final mainPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15;

    final softPaint = Paint()
      ..color = accentColor.withAlpha(70)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .75;

    final aspectPaint = Paint()
      ..color = accentColor.withAlpha(95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .75;

    // circulos
    canvas.drawCircle(center, radius.toDouble(), mainPaint);
    canvas.drawCircle(center, radius * .84, softPaint);
    canvas.drawCircle(center, radius * .66, softPaint);
    canvas.drawCircle(center, radius * .47, softPaint);

    // dividir la rueda
    for (int i = 0; i < 12; i++) {
      final angle = -math.pi / 2 + i * 2 * math.pi / 12;

      final outer = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final inner = Offset(
        center.dx + radius * .47 * math.cos(angle),
        center.dy + radius * .47 * math.sin(angle),
      );

      canvas.drawLine(inner, outer, softPaint);
    }

    // numeros de las casas
    for (int i = 0; i < 12; i++) {
      final angle = -math.pi / 2 + (i + .5) * 2 * math.pi / 12;

      final point = Offset(
        center.dx + radius * .75 * math.cos(angle),
        center.dy + radius * .75 * math.sin(angle),
      );

      final text = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: accentColor.withAlpha(175),
            fontSize: math.max(7, radius * .036),
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      text.layout();

      text.paint(
        canvas,
        Offset(point.dx - text.width / 2, point.dy - text.height / 2),
      );
    }

    // planetas
    for (final planet in planets) {
      final absoluteDegree = _absoluteDegree(planet.sign, planet.degree);

      final angle = -math.pi / 2 + absoluteDegree * math.pi / 180;

      final point = Offset(
        center.dx + radius * .59 * math.cos(angle),
        center.dy + radius * .59 * math.sin(angle),
      );

      canvas.drawCircle(
        point,
        math.max(2.3, radius * .014),
        Paint()..color = accentColor,
      );

      final symbolPoint = Offset(
        center.dx + radius * .92 * math.cos(angle),
        center.dy + radius * .92 * math.sin(angle),
      );

      final symbol = TextPainter(
        text: TextSpan(
          text: planetSymbol(planet.planet),
          style: TextStyle(
            color: accentColor,
            fontSize: math.max(10, radius * .055),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      symbol.layout();

      symbol.paint(
        canvas,
        Offset(
          symbolPoint.dx - symbol.width / 2,
          symbolPoint.dy - symbol.height / 2,
        ),
      );
    }

    // aspectos
    for (final aspect in aspects) {
      ChartPlanet? firstPlanet;
      ChartPlanet? secondPlanet;

      for (final planet in planets) {
        if (planet.planet.trim().toLowerCase() ==
            aspect.first.trim().toLowerCase()) {
          firstPlanet = planet;
        }

        if (planet.planet.trim().toLowerCase() ==
            aspect.second.trim().toLowerCase()) {
          secondPlanet = planet;
        }
      }

      if (firstPlanet == null || secondPlanet == null) {
        continue;
      }

      final degree1 = _absoluteDegree(firstPlanet.sign, firstPlanet.degree);
      final degree2 = _absoluteDegree(secondPlanet.sign, secondPlanet.degree);

      final angle1 = -math.pi / 2 + degree1 * math.pi / 180;
      final angle2 = -math.pi / 2 + degree2 * math.pi / 180;

      final point1 = Offset(
        center.dx + radius * .43 * math.cos(angle1),
        center.dy + radius * .43 * math.sin(angle1),
      );

      final point2 = Offset(
        center.dx + radius * .43 * math.cos(angle2),
        center.dy + radius * .43 * math.sin(angle2),
      );

      canvas.drawLine(point1, point2, aspectPaint);
    }
  }

  // convertir signo y grado a posicion dentro de los 360 grados
  double _absoluteDegree(String sign, double degree) {
    const starts = {
      'aries': 0.0,
      'taurus': 30.0,
      'gemini': 60.0,
      'cancer': 90.0,
      'leo': 120.0,
      'virgo': 150.0,
      'libra': 180.0,
      'scorpio': 210.0,
      'sagittarius': 240.0,
      'capricorn': 270.0,
      'aquarius': 300.0,
      'pisces': 330.0,
    };

    return (starts[sign.trim().toLowerCase()] ?? 0) + degree;
  }

  @override
  bool shouldRepaint(covariant NatalWheelPainter oldDelegate) {
    return (oldDelegate.accentColor != accentColor ||
        oldDelegate.planets != planets ||
        oldDelegate.aspects != aspects ||
        oldDelegate.houses != houses);
  }
}
