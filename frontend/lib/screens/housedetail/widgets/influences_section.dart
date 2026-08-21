import 'package:flutter/material.dart';

import '../../../l10n/domain_labels.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import '../../../theme/card_decorations.dart';
import 'section_card.dart';

class InfluencesSection extends StatelessWidget {
  final ChartHouse house;
  final Color accentColor;
  final bool compact;

  const InfluencesSection({
    super.key,
    required this.house,
    required this.accentColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final supportive = house.supportiveInfluences;
    final challenging = house.challengingInfluences;

    return SectionCard(
      title: l10n.influencesTitle,
      accentColor: accentColor,
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (supportive.isNotEmpty)
                  InfluenceGroup(
                    title: l10n.supportiveLabel,
                    influences: supportive,
                    accentColor: accentColor,
                  ),
                if (supportive.isNotEmpty && challenging.isNotEmpty)
                  const SizedBox(height: 22),
                if (challenging.isNotEmpty)
                  InfluenceGroup(
                    title: l10n.challengingLabel,
                    influences: challenging,
                    accentColor: accentColor,
                  ),
              ],
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final bothExist =
                    supportive.isNotEmpty && challenging.isNotEmpty;

                if (bothExist && constraints.maxWidth >= 650) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InfluenceGroup(
                          title: l10n.supportiveLabel,
                          influences: supportive,
                          accentColor: accentColor,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        width: 1,
                        constraints: const BoxConstraints(minHeight: 80),
                        color: const Color(0xFFE6DEE5),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: InfluenceGroup(
                          title: l10n.challengingLabel,
                          influences: challenging,
                          accentColor: accentColor,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (supportive.isNotEmpty)
                      InfluenceGroup(
                        title: l10n.supportiveLabel,
                        influences: supportive,
                        accentColor: accentColor,
                      ),
                    if (supportive.isNotEmpty && challenging.isNotEmpty)
                      const SizedBox(height: 22),
                    if (challenging.isNotEmpty)
                      InfluenceGroup(
                        title: l10n.challengingLabel,
                        influences: challenging,
                        accentColor: accentColor,
                      ),
                  ],
                );
              },
            ),
    );
  }
}

class InfluenceGroup extends StatelessWidget {
  final String title;
  final List<HouseInfluence> influences;
  final Color accentColor;

  const InfluenceGroup({
    super.key,
    required this.title,
    required this.influences,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accentColor,
            fontSize: 9,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        ...influences.map(
          (influence) =>
              InfluenceRow(influence: influence, accentColor: accentColor),
        ),
      ],
    );
  }
}

class InfluenceRow extends StatelessWidget {
  final HouseInfluence influence;
  final Color accentColor;

  const InfluenceRow({
    super.key,
    required this.influence,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: bottomLineDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              aspectSymbol(influence.type),
              style: TextStyle(color: accentColor, fontSize: 22),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${localizedPlanetName(context, influence.first)} '
                  '${localizedAspectName(context, influence.type)} '
                  '${localizedPlanetName(context, influence.second)}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF231729),
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatAstrologyDegree(influence.orb)} · '
                  '${localizedStrength(context, influence.strength)}',
                  style: const TextStyle(
                    color: Color(0xFF817380),
                    fontSize: 10.5,
                  ),
                ),
                if (influence.interpretation.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    influence.interpretation,
                    style: const TextStyle(
                      color: Color(0xFF4F434F),
                      fontSize: 11.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
