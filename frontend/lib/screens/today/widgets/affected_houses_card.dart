import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../l10n/today_labels.dart';
import '../../../models/today_model.dart';
import '../../../theme/card_decorations.dart';
import '../../../utils/astrology_symbols.dart';
import 'today_title_line.dart';

class AffectedHousesCard extends StatelessWidget {
  final List<TodayHouse> houses;
  final Color accentColor;

  const AffectedHousesCard({
    super.key,
    required this.houses,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            TodayTitleLine(
              title: l10n.affectedHousesTitle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 20),
            if (houses.isEmpty)
              Text(l10n.noActiveHousesMessage)
            else
              ...houses.take(3).map(
                    (house) => HouseRow(house: house, accentColor: accentColor),
                  ),
          ],
        ),
      ),
    );
  }
}

class HouseRow extends StatelessWidget {
  final TodayHouse house;
  final Color accentColor;

  const HouseRow({super.key, required this.house, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: bottomLineDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withAlpha(16),
            ),
            child: Text(
              romanNumeral(house.number),
              style: TextStyle(
                color: accentColor,
                fontFamily: 'Gothica2',
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizedTodayHouseTitle(context, house.number),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  localizedTodayHouseSubtitle(
                    context,
                    house.number,
                    house.subtitle,
                  ),
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  localizedTodayHouseDescription(
                    context,
                    house.number,
                    house.description,
                  ),
                  style: const TextStyle(
                    color: Color(0xFF625961),
                    fontSize: 12,
                    height: 1.45,
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
