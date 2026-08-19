import 'package:flutter/material.dart';

import '../../../models/house_model.dart';
import '../../../theme/card_decorations.dart';
import '../../../utils/astrology_symbols.dart';

class HouseCard extends StatelessWidget {
  final HouseModel house;
  final Color accentColor;
  final VoidCallback onTap;
  final bool compact;

  const HouseCard({
    super.key,
    required this.house,
    required this.accentColor,
    required this.onTap,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: double.infinity,
          decoration: cardDecoration(),
          child: Padding(
            padding: EdgeInsets.all(
              compact ? 17 : 19,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // NÚMERO + NIVEL DE ACTIVIDAD
                // ==================================================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.roman,
                      style: TextStyle(
                        color: accentColor,
                        fontFamily: 'serif',
                        fontSize: compact ? 28 : 31,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Spacer(),

                    if (house.activity.level.trim().isNotEmpty)
                      Flexible(
                        child: HouseStrengthBadge(
                          label: house.activity.level,
                          accentColor: accentColor,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 13),

                // ==================================================
                // TÍTULO
                // ==================================================

                Text(
                  house.title.trim().isEmpty
                      ? 'HOUSE ${house.house}'
                      : house.title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF231729),
                    fontSize: compact ? 11.5 : 12,
                    height: 1.3,
                    letterSpacing: .9,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                if (house.subtitle.trim().isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    house.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF817380),
                      fontSize: 10.5,
                      height: 1.4,
                    ),
                  ),
                ],

                const SizedBox(height: 15),

                // ==================================================
                // SIGNO + GRADO
                // ==================================================

                Row(
                  children: [
                    Icon(
                      Icons.radio_button_checked,
                      color: accentColor,
                      size: 14,
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        '${house.sign} · ${house.formattedDegree}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF4F434F),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ==================================================
                // REGENTE
                // ==================================================

                Row(
                  children: [
                    Text(
                      planetSymbol(house.ruler),
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        house.ruler.trim().isEmpty
                            ? 'Ruler · —'
                            : 'Ruler · ${house.ruler}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF817380),
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ==================================================
                // PLANETAS EN LA CASA
                // ==================================================

                if (house.planets.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 7,
                    children: house.planets.map((planet) {
                      return Text(
                        '${planet.symbol} ${planet.name}',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  )
                else
                  const Text(
                    'No natal planets',
                    style: TextStyle(
                      color: Color(0xFF9B8F9A),
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                const SizedBox(height: 15),

                // ==================================================
                // TEMAS + FLECHA
                // ==================================================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        house.keywords
                            .take(3)
                            .join(' · '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF817380),
                          fontSize: 9.5,
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Icon(
                      Icons.arrow_forward,
                      color: accentColor,
                      size: 17,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HouseStrengthBadge extends StatelessWidget {
  final String label;
  final Color accentColor;

  const HouseStrengthBadge({
    super.key,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: accentColor,
          fontSize: 8,
          letterSpacing: .7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}