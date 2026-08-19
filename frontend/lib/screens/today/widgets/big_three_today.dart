import 'package:flutter/material.dart';

import '../../../models/today_model.dart';
import '../../../theme/card_decorations.dart';
import 'today_title_line.dart';

class BigThreeToday extends StatelessWidget {
  final TodayBigThree data;
  final Color accentColor;

  const BigThreeToday({
    super.key,
    required this.data,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TodayTitleLine(title: 'YOUR BIG THREE', accentColor: accentColor),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: BigItem(
                    symbol: '☉',
                    label: 'SUN',
                    value: data.sun,
                    accentColor: accentColor,
                  ),
                ),
                _verticalDivider(),
                Expanded(
                  child: BigItem(
                    symbol: '☾',
                    label: 'MOON',
                    value: data.moon,
                    accentColor: accentColor,
                  ),
                ),
                _verticalDivider(),
                Expanded(
                  child: BigItem(
                    symbol: '↑',
                    label: 'RISING',
                    value: data.rising,
                    accentColor: accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 72, color: const Color(0xFFE6DEE5));
  }
}

class BigItem extends StatelessWidget {
  final String symbol;
  final String label;
  final String value;
  final Color accentColor;

  const BigItem({
    super.key,
    required this.symbol,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(symbol, style: TextStyle(color: accentColor, fontSize: 30)),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: accentColor,
            fontSize: 9,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          value.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF251F25),
            fontFamily: 'Gothica2',
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
