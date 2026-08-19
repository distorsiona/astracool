import 'package:flutter/material.dart';

import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import 'section_card.dart';

class InterpretationSection extends StatelessWidget {
  final ChartHouse house;
  final Color accentColor;

  const InterpretationSection({
    super.key,
    required this.house,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'YOUR HOUSE ${romanNumeral(house.number)}',
      accentColor: accentColor,
      child: Text(
        house.interpretation,
        style: const TextStyle(
          color: Color(0xFF4F434F),
          fontSize: 13,
          height: 1.65,
        ),
      ),
    );
  }
}
