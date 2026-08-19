import 'package:flutter/material.dart';

import '../../../models/house_model.dart';
import '../../../theme/card_decorations.dart';

import 'section_card.dart';

class PlanetsInHouseSection extends StatelessWidget {
  final HouseModel house;
  final Color accentColor;

  const PlanetsInHouseSection({
    super.key,
    required this.house,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'PLANETS IN THIS HOUSE',
      accentColor: accentColor,
      child: house.planets.isEmpty
          ? const Text(
              'There are no natal planets in this house. '
              'This does not mean the house is unimportant. '
              'Its sign and ruling planet still describe how '
              'this area of life is expressed.',
              style: TextStyle(
                color: Color(0xFF4F434F),
                fontSize: 12.5,
                height: 1.6,
              ),
            )
          : Column(
              children: house.planets.map(
                (planet) {
                  return PlanetInHouseRow(
                    planet: planet,
                    accentColor:
                        accentColor,
                  );
                },
              ).toList(),
            ),
    );
  }
}

class PlanetInHouseRow
    extends StatelessWidget {
  final HousePlanetModel planet;
  final Color accentColor;

  const PlanetInHouseRow({
    super.key,
    required this.planet,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration:
          bottomLineDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              planet.symbol,
              style: TextStyle(
                color: accentColor,
                fontSize: 25,
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  planet.name,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color:
                        Color(0xFF231729),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Wrap(
                  spacing: 5,
                  runSpacing: 3,
                  children: [
                    if (planet.sign != null &&
                        planet.sign!
                            .trim()
                            .isNotEmpty)
                      Text(
                        planet.sign!,
                        style:
                            const TextStyle(
                          color:
                              Color(0xFF817380),
                          fontSize: 11,
                        ),
                      ),

                    if (planet.formattedDegree !=
                            null &&
                        planet.formattedDegree!
                            .trim()
                            .isNotEmpty)
                      Text(
                        '· ${planet.formattedDegree}',
                        style:
                            const TextStyle(
                          color:
                              Color(0xFF817380),
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          if (planet.isRetrograde) ...[
            const SizedBox(width: 8),

            Text(
              'R',
              style: TextStyle(
                color: accentColor,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}