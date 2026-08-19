import 'package:flutter/material.dart';

import '../../../models/natal_chart_model.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';

class BigThreePanel extends StatelessWidget {
  final BigThreeData bigThree;
  final Color accentColor;
  final ChartLayout layout;

  const BigThreePanel({
    super.key,
    required this.bigThree,
    required this.accentColor,
    required this.layout,
  });

  bool get isMobile => layout == ChartLayout.mobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: double.infinity, height: 4, color: accentColor),
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 16 : 22,
              isMobile ? 16 : 19,
              isMobile ? 16 : 22,
              isMobile ? 18 : 22,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Divider(color: accentColor.withAlpha(65))),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'YOUR BIG THREE',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 10,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: accentColor.withAlpha(65))),
                  ],
                ),
                const SizedBox(height: 20),
                BigThreeRow(
                  symbol: '☉',
                  title: 'SUN',
                  placement: bigThree.sun,
                  accentColor: accentColor,
                  compact: isMobile,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, color: Color(0xFFE9E0E8)),
                ),
                BigThreeRow(
                  symbol: '☾',
                  title: 'MOON',
                  placement: bigThree.moon,
                  accentColor: accentColor,
                  compact: isMobile,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, color: Color(0xFFE9E0E8)),
                ),
                BigThreeRow(
                  symbol: '↑',
                  title: 'RISING',
                  placement: bigThree.rising,
                  accentColor: accentColor,
                  compact: isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigThreeRow extends StatelessWidget {
  final String symbol;
  final String title;
  final ChartPlacement placement;
  final Color accentColor;
  final bool compact;

  const BigThreeRow({
    super.key,
    required this.symbol,
    required this.title,
    required this.placement,
    required this.accentColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final sign =
        placement.sign.trim().isEmpty ? '—' : placement.sign.toUpperCase();

    return Row(
      children: [
        SizedBox(
          width: compact ? 68 : 82,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                symbol,
                style: TextStyle(
                  color: accentColor,
                  fontSize: compact ? 24 : 27,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 9,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sign,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF231729),
                  fontFamily: 'serif',
                  fontSize: compact ? 20 : 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                formatAstrologyDegree(placement.degree),
                style: const TextStyle(color: Color(0xFF817380), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
