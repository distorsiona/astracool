import 'package:flutter/material.dart';

import '../../../models/today_model.dart';
import '../../../theme/card_decorations.dart';
import 'today_title_line.dart';

class TodayHero extends StatelessWidget {
  final TodayModel data;
  final Color accentColor;
  final bool mobile;

  const TodayHero({
    super.key,
    required this.data,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: EdgeInsets.all(mobile ? 22 : 30),
        child: Column(
          children: [
            Text(
              'TODAY',
              style: TextStyle(
                color: accentColor,
                fontFamily: 'Gothica2',
                fontSize: mobile ? 36 : 44,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.date.toUpperCase(),
              style: TextStyle(
                color: accentColor,
                fontSize: 13,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: mobile ? 86 : 100,
              height: mobile ? 86 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accentColor.withAlpha(215),
                    accentColor.withAlpha(115),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withAlpha(35),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '☾',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'MOON IN ${data.moonSign.toUpperCase()}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor,
                fontSize: 16,
                letterSpacing: .7,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              data.moonSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF756B72),
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 30),
            TodayTitleLine(
              title: 'YOUR ENERGY TODAY',
              accentColor: accentColor,
            ),
            const SizedBox(height: 22),
            Text(
              data.interpretation,
              style: const TextStyle(
                color: Color(0xFF332C32),
                fontSize: 14,
                height: 1.7,
              ),
            ),
            if (data.quote.isNotEmpty) ...[
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '“${data.quote}”',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 13,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
