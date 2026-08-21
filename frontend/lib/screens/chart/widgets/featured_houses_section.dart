import 'package:flutter/material.dart';

import '../../../l10n/domain_labels.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';
import 'chart_section_title.dart';

class FeaturedHousesSection extends StatelessWidget {
  final List<FeaturedHouse> houses;
  final Color accentColor;
  final ChartLayout layout;
  final VoidCallback onViewAll;
  final ValueChanged<int> onHouseTap;

  const FeaturedHousesSection({
    super.key,
    required this.houses,
    required this.accentColor,
    required this.layout,
    required this.onViewAll,
    required this.onHouseTap,
  });

  bool get isMobile => layout == ChartLayout.mobile;

  @override
  Widget build(BuildContext context) {
    if (houses.isEmpty) {
      return const SizedBox.shrink();
    }

    final visible = houses.take(4).toList();
    final title = AppLocalizations.of(context)!.mostActiveHousesTitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // en teléfonos muy pequeños ponemos el link debajo del titulo
            if (constraints.maxWidth < 420) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChartSectionTitle(
                    title: title,
                    accentColor: accentColor,
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ViewAllButton(
                      accentColor: accentColor,
                      onPressed: onViewAll,
                    ),
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: ChartSectionTitle(
                    title: title,
                    accentColor: accentColor,
                  ),
                ),
                const SizedBox(width: 12),
                ViewAllButton(accentColor: accentColor, onPressed: onViewAll),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        // no usamos grid con altura fija: wrap deja que cada card crezca
        // según la cantidad de información que tenga.
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;

            const gap = 16.0;

            final cardWidth = isMobile ? maxWidth : (maxWidth - gap) / 2;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: visible.map((house) {
                return SizedBox(
                  width: cardWidth,
                  child: FeaturedHouseCard(
                    house: house,
                    accentColor: accentColor,
                    onTap: () => onHouseTap(house.number),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class ViewAllButton extends StatelessWidget {
  final Color accentColor;
  final VoidCallback onPressed;

  const ViewAllButton({
    super.key,
    required this.accentColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.viewAllHouses,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 15, color: accentColor),
        ],
      ),
    );
  }
}

class FeaturedHouseCard extends StatelessWidget {
  final FeaturedHouse house;
  final Color accentColor;
  final VoidCallback onTap;

  const FeaturedHouseCard({
    super.key,
    required this.house,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: double.infinity,
          decoration: cardDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      romanNumeral(house.number),
                      style: TextStyle(
                        color: accentColor,
                        fontFamily: 'serif',
                        fontSize: 28,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (house.strengthLabel.trim().isNotEmpty)
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            localizedActivityLevel(
                                context, house.strengthLabel),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 8,
                              letterSpacing: .8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  house.title.trim().isEmpty
                      ? l10n.houseFallbackTitle(house.number)
                      : localizeHouseTitle(
                          context,
                          house.number,
                          house.title,
                        ).toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF231729),
                    fontSize: 12,
                    height: 1.25,
                    letterSpacing: .9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (house.subtitle.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    localizeHouseSubtitle(
                      context,
                      house.number,
                      house.subtitle,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF817380),
                      fontSize: 10,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  '${localizedSignName(context, house.sign)} · '
                  '${formatAstrologyDegree(house.degree)}',
                  style: const TextStyle(
                    color: Color(0xFF4F434F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  house.ruler.trim().isEmpty
                      ? l10n.rulerUnknown
                      : l10n.rulerWithName(
                          localizedPlanetName(context, house.ruler),
                        ),
                  style: const TextStyle(
                    color: Color(0xFF817380),
                    fontSize: 10.5,
                  ),
                ),
                if (house.planets.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 7,
                    children: house.planets.map((planet) {
                      return Text(
                        '${planetSymbol(planet.planet)} '
                        '${localizedPlanetName(context, planet.planet)}',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        house.themes
                            .take(3)
                            .map((t) => localizeHouseKeyword(context, t))
                            .join(' · '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF817380),
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.arrow_forward, size: 17, color: accentColor),
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
