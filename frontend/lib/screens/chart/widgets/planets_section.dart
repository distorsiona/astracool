import 'package:flutter/material.dart';

import '../../../l10n/domain_labels.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';
import 'chart_section_title.dart';

class PlanetsSection extends StatelessWidget {
  final List<ChartPlanet> planets;
  final Color accentColor;
  final ChartLayout layout;

  const PlanetsSection({
    super.key,
    required this.planets,
    required this.accentColor,
    required this.layout,
  });

  bool get compact => layout != ChartLayout.desktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout == ChartLayout.mobile ? 18 : 24),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChartSectionTitle(title: l10n.planetsTitle, accentColor: accentColor),
          const SizedBox(height: 18),
          if (planets.isEmpty)
            Text(l10n.noPlanetDataMessage)
          else
            ...planets.map(
              (planet) => PlanetRow(
                planet: planet,
                accentColor: accentColor,
                compact: compact,
              ),
            ),
        ],
      ),
    );
  }
}

class PlanetRow extends StatelessWidget {
  final ChartPlanet planet;
  final Color accentColor;
  final bool compact;

  const PlanetRow({
    super.key,
    required this.planet,
    required this.accentColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (compact) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: bottomLineDecoration(),
        child: Row(
          children: [
            SizedBox(
              width: 38,
              child: Text(
                planetSymbol(planet.planet),
                style: TextStyle(color: accentColor, fontSize: 22),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          localizedPlanetName(context, planet.planet),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (planet.retrograde)
                        Text(
                          'R',
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${localizedSignName(context, planet.sign)} · '
                    '${formatAstrologyDegree(planet.degree)} · '
                    '${planet.house == null ? l10n.noHouseInline : l10n.houseNumberInline(planet.house!)}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF817380),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: bottomLineDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: 38,
            child: Text(
              planetSymbol(planet.planet),
              style: TextStyle(color: accentColor, fontSize: 22),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              localizedPlanetName(context, planet.planet),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              localizedSignName(context, planet.sign),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(child: Text(formatAstrologyDegree(planet.degree))),
          Expanded(
            child: Text(
              planet.house == null
                  ? '—'
                  : l10n.houseNumberInline(planet.house!),
            ),
          ),
          SizedBox(
            width: 26,
            child: planet.retrograde
                ? Text(
                    'R',
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
