import 'package:flutter/material.dart';

import '../../../models/today_model.dart';
import '../../../theme/card_decorations.dart';
import 'today_title_line.dart';

class ThemesCard extends StatelessWidget {
  final List<TodayTheme> themes;
  final Color accentColor;

  const ThemesCard({
    super.key,
    required this.themes,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            TodayTitleLine(title: "TODAY'S THEMES", accentColor: accentColor),
            const SizedBox(height: 20),
            ...themes.map(
              (theme) => ThemeRow(theme: theme, accentColor: accentColor),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentColor.withAlpha(14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    '✦',
                    style: TextStyle(color: accentColor, fontSize: 28),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Tu día refleja la interacción entre tu carta natal y '
                      'el cielo actual.',
                      style: TextStyle(
                        color: Color(0xFF554B53),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeRow extends StatelessWidget {
  final TodayTheme theme;
  final Color accentColor;

  const ThemeRow({super.key, required this.theme, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final value = theme.value.clamp(0, 5);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              theme.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 9),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          index < value ? accentColor : const Color(0xFFE8E5E7),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            '$value/5',
            style: const TextStyle(color: Color(0xFF625961), fontSize: 11),
          ),
        ],
      ),
    );
  }
}
