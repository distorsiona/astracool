import 'package:flutter/material.dart';

import '../../../models/house_model.dart';
import '../../../theme/card_decorations.dart';
import '../../../utils/astrology_symbols.dart';

import '../house_layout.dart';

class HouseHeroCard extends StatelessWidget {
  final HouseModel house;
  final Color accentColor;
  final HouseLayout layout;

  const HouseHeroCard({
    super.key,
    required this.house,
    required this.accentColor,
    required this.layout,
  });

  bool get isMobile => layout == HouseLayout.mobile;

  bool get isTablet => layout == HouseLayout.tablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile
            ? 22
            : isTablet
                ? 26
                : 32,
      ),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // NÚMERO ROMANO + NIVEL DE ACTIVIDAD
          // ======================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                house.roman,
                style: TextStyle(
                  color: accentColor,
                  fontFamily: 'serif',
                  fontSize: isMobile
                      ? 46
                      : isTablet
                          ? 54
                          : 64,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 14),
              const Spacer(),
              if (house.activity.level.trim().isNotEmpty)
                Flexible(
                  child: StrengthBadge(
                    label: house.activity.level,
                    accentColor: accentColor,
                  ),
                ),
            ],
          ),

          SizedBox(
            height: isMobile ? 18 : 22,
          ),

          // ======================================================
          // NOMBRE DE LA CASA
          // ======================================================

          Text(
            house.title.trim().isEmpty
                ? 'HOUSE ${house.house}'
                : house.title.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF231729),
              fontFamily: 'serif',
              fontSize: isMobile
                  ? 25
                  : isTablet
                      ? 29
                      : 34,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (house.subtitle.trim().isNotEmpty) ...[
            const SizedBox(height: 7),
            Text(
              house.subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF817380),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],

          SizedBox(
            height: isMobile ? 22 : 26,
          ),

          // ======================================================
          // SIGNO + GRADO + REGENTE
          // ======================================================

          Container(
            padding: const EdgeInsets.only(
              left: 17,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: accentColor,
                  width: 3,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.sign.trim().isEmpty
                      ? '—'
                      : house.sign.toUpperCase(),
                  style: TextStyle(
                    color: const Color(0xFF231729),
                    fontSize: isMobile ? 15 : 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  house.formattedDegree,
                  style: const TextStyle(
                    color: Color(0xFF817380),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 13),

                Row(
                  children: [
                    Text(
                      planetSymbol(
                        house.ruler,
                      ),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 19,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        house.ruler.trim().isEmpty
                            ? 'Ruler · —'
                            : 'Ruler · ${house.ruler}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF4F434F),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ======================================================
          // KEYWORDS
          // ======================================================

          if (house.keywords.isNotEmpty) ...[
            const SizedBox(height: 24),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: house.keywords.map((keyword) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(14),
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          accentColor.withAlpha(35),
                    ),
                  ),
                  child: Text(
                    keyword,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class StrengthBadge extends StatelessWidget {
  final String label;
  final Color accentColor;

  const StrengthBadge({
    super.key,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(18),
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: accentColor,
          fontSize: 9,
          letterSpacing: .9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}