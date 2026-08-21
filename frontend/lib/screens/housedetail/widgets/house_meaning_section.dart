import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../models/house_model.dart';

import '../helpers/house_meanings.dart';
import 'section_card.dart';

class HouseMeaningSection extends StatelessWidget {
  final HouseModel house;
  final Color accentColor;

  const HouseMeaningSection({
    super.key,
    required this.house,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: AppLocalizations.of(context)!.whatThisHouseRulesTitle,
      accentColor: accentColor,
      child: Text(
        defaultHouseMeaning(
          context,
          house.house,
        ),
        style: const TextStyle(
          color: Color(0xFF4F434F),
          fontSize: 13,
          height: 1.65,
        ),
      ),
    );
  }
}
