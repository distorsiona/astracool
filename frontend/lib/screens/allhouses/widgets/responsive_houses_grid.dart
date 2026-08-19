import 'package:flutter/material.dart';

import '../../../models/house_model.dart';
import 'house_card.dart';

class ResponsiveHousesGrid extends StatelessWidget {
  final List<HouseModel> houses;

  final Color accentColor;

  final bool isMobile;
  final bool isTablet;

  final ValueChanged<HouseModel> onHouseTap;

  const ResponsiveHousesGrid({
    super.key,
    required this.houses,
    required this.accentColor,
    required this.isMobile,
    required this.isTablet,
    required this.onHouseTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;

        const gap = 16.0;

        int columns;

        if (isMobile) {
          columns = 1;
        } else if (isTablet) {
          columns = 2;
        } else {
          columns = 2;
        }

        final cardWidth = columns == 1
            ? available
            : (available - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: houses.map((house) {
            return SizedBox(
              width: cardWidth,
              child: HouseCard(
                house: house,
                accentColor: accentColor,
                compact: isMobile,
                onTap: () => onHouseTap(house),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}