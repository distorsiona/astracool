import 'package:flutter/material.dart';

import '../../../theme/card_decorations.dart';

class BottomSummary extends StatelessWidget {
  final String focus;
  final String luckyTime;
  final String luckyColor;
  final Color accentColor;
  final bool mobile;

  const BottomSummary({
    super.key,
    required this.focus,
    required this.luckyTime,
    required this.luckyColor,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return Container(
        width: double.infinity,
        decoration: cardDecoration(),
        child: Column(
          children: [
            SummaryItem(
              title: "TODAY'S FOCUS",
              value: focus,
              accentColor: accentColor,
            ),
            const Divider(height: 1),
            SummaryItem(
              title: 'LUCKY TIME',
              value: luckyTime,
              accentColor: accentColor,
            ),
            const Divider(height: 1),
            SummaryItem(
              title: 'LUCKY COLOR',
              value: luckyColor,
              accentColor: accentColor,
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SummaryItem(
              title: "TODAY'S FOCUS",
              value: focus,
              accentColor: accentColor,
            ),
          ),
          _summaryDivider(),
          Expanded(
            child: SummaryItem(
              title: 'LUCKY TIME',
              value: luckyTime,
              accentColor: accentColor,
            ),
          ),
          _summaryDivider(),
          Expanded(
            child: SummaryItem(
              title: 'LUCKY COLOR',
              value: luckyColor,
              accentColor: accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryDivider() {
    return Container(width: 1, height: 70, color: const Color(0xFFE6DEE5));
  }
}

class SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color accentColor;

  const SummaryItem({
    super.key,
    required this.title,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          Text('✦', style: TextStyle(color: accentColor, fontSize: 24)),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF625961),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
