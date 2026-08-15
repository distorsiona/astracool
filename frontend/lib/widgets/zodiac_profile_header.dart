import 'package:flutter/material.dart';

import '../models/zodiac_profile_model.dart';
import 'zodiac_attribute_item.dart';

class ZodiacProfileHeader extends StatelessWidget {
  final ZodiacProfileModel profile;
  final Color accentColor;

  const ZodiacProfileHeader({
    super.key,
    required this.profile,
    required this.accentColor,
  });

  IconData _elementIcon() {
    switch (profile.element) {
      case ZodiacElement.fire:
        return Icons.local_fire_department_outlined;
      case ZodiacElement.earth:
        return Icons.landscape_outlined;
      case ZodiacElement.air:
        return Icons.air;
      case ZodiacElement.water:
        return Icons.water_drop_outlined;
    }
  }

  String _elementText() {
    switch (profile.element) {
      case ZodiacElement.fire:
        return 'Fire';
      case ZodiacElement.earth:
        return 'Earth';
      case ZodiacElement.air:
        return 'Air';
      case ZodiacElement.water:
        return 'Water';
    }
  }

  String _modalityText() {
    switch (profile.modality) {
      case ZodiacModality.cardinal:
        return 'Cardinal';
      case ZodiacModality.fixed:
        return 'Fixed';
      case ZodiacModality.mutable:
        return 'Mutable';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Row(
        children: [
          Container(
            width: 52,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const SizedBox(width: 28),

          SizedBox(
            width: 160,
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    profile.sign,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 58,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    profile.dateRange,
                    style: const TextStyle(
                      color: Color(0xFF202020),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 230,
            width: 1,
            color: accentColor.withOpacity(.7),
          ),

          const SizedBox(width: 36),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZodiacAttributeItem(
                icon: Icon(
                  _elementIcon(),
                  color: accentColor,
                  size: 34,
                ),
                title: 'Element',
                value: _elementText(),
                accentColor: accentColor,
              ),
              const SizedBox(height: 22),
              ZodiacAttributeItem(
                icon: Icon(
                  Icons.circle_outlined,
                  color: accentColor,
                  size: 34,
                ),
                title: 'Ruling planet',
                value: profile.rulingPlanet,
                accentColor: accentColor,
              ),
              const SizedBox(height: 22),
              ZodiacAttributeItem(
                icon: Icon(
                  Icons.crop_square,
                  color: accentColor,
                  size: 34,
                ),
                title: 'Modality',
                value: _modalityText(),
                accentColor: accentColor,
              ),
            ],
          ),

          const Spacer(),

          Text(
            profile.symbol,
            style: TextStyle(
              fontSize: 220,
              height: 1,
              color: accentColor,
            ),
          ),

          const SizedBox(width: 30),
        ],
      ),
    );
  }
}