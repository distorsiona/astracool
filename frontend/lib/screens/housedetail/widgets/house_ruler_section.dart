import 'package:flutter/material.dart';

import '../../../models/house_detail_model.dart';
import '../../../models/house_model.dart';
import '../../../utils/astrology_symbols.dart';

import 'section_card.dart';

class HouseRulerSection extends StatelessWidget {
  final HouseModel house;

  final RulerPlacementModel? rulerPlacement;

  final Color accentColor;
  final bool compact;

  const HouseRulerSection({
    super.key,
    required this.house,
    required this.rulerPlacement,
    required this.accentColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final ruler = rulerPlacement;

    return SectionCard(
      title: 'HOUSE RULER',
      accentColor: accentColor,
      child: ruler == null
          ? _buildWithoutPlacement()
          : _buildPlacement(
              ruler,
            ),
    );
  }

  // ============================================================
  // SIN POSICIÓN DEL REGENTE
  // ============================================================

  Widget _buildWithoutPlacement() {
    return Text(
      house.ruler.trim().isEmpty
          ? 'No ruling planet information is available.'
          : '${house.ruler} rules this house.',
      style: const TextStyle(
        color: Color(0xFF4F434F),
        fontSize: 12.5,
        height: 1.55,
      ),
    );
  }

  // ============================================================
  // REGENTE REAL EN LA CARTA
  // ============================================================

  Widget _buildPlacement(
    RulerPlacementModel ruler,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: compact ? 42 : 50,
          child: Text(
            ruler.symbol.isNotEmpty
                ? ruler.symbol
                : planetSymbol(
                    ruler.planet,
                  ),
            style: TextStyle(
              color: accentColor,
              fontSize: compact ? 27 : 31,
            ),
          ),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                ruler.planet.toUpperCase(),
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF231729),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              Wrap(
                spacing: 5,
                runSpacing: 3,
                children: [
                  if (ruler.sign != null &&
                      ruler.sign!.trim().isNotEmpty)
                    Text(
                      ruler.sign!,
                      style: const TextStyle(
                        color:
                            Color(0xFF817380),
                        fontSize: 12,
                      ),
                    ),

                  if (ruler.formattedDegree !=
                          null &&
                      ruler.formattedDegree!
                          .trim()
                          .isNotEmpty)
                    Text(
                      '· ${ruler.formattedDegree}',
                      style: const TextStyle(
                        color:
                            Color(0xFF817380),
                        fontSize: 12,
                      ),
                    ),

                  if (ruler.house != null)
                    Text(
                      '· House ${romanNumeral(ruler.house!)}',
                      style: const TextStyle(
                        color:
                            Color(0xFF817380),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),

              if (ruler.isRetrograde) ...[
                const SizedBox(height: 6),

                Text(
                  'Retrograde',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}