import 'package:flutter/material.dart';

import '../l10n/domain_labels.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/zodiac_profile_model.dart';
import '../theme/zodiac_theme.dart';

class BigThreeCard extends StatelessWidget {
  final BigThreeItem sun;
  final BigThreeItem moon;
  final BigThreeItem rising;

  final Color accentColor;

  const BigThreeCard({
    super.key,
    required this.sun,
    required this.moon,
    required this.rising,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 34,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D0CA),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: accentColor.withAlpha(100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  AppLocalizations.of(context)!.bigThreeTitle,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 15,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: accentColor.withAlpha(100),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _BigThreeItemView(
                  item: sun,
                  accentColor: accentColor,
                ),
              ),
              _separator(),
              Expanded(
                child: _BigThreeItemView(
                  item: moon,
                  accentColor: accentColor,
                ),
              ),
              _separator(),
              Expanded(
                child: _BigThreeItemView(
                  item: rising,
                  accentColor: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _separator() {
    return Container(
      width: 1,
      height: 95,
      color: const Color(0xFFD5D5CF),
    );
  }
}

class _BigThreeItemView extends StatelessWidget {
  final BigThreeItem item;
  final Color accentColor;

  const _BigThreeItemView({
    required this.item,
    required this.accentColor,
  });

  String _localizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (item.label.trim().toLowerCase()) {
      case 'sun':
        return l10n.sunLabel;
      case 'moon':
        return l10n.moonLabel;
      case 'rising':
        return l10n.risingLabel;
      default:
        return item.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          item.symbol,
          style: TextStyle(
            color: accentColor,
            fontSize: 40,
            height: 1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _localizedLabel(context).toUpperCase(),
          style: TextStyle(
            color: accentColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          localizedSignName(context, item.sign).toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF202020),
            fontFamily: ZodiacTheme.fontSignName,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item.formattedDegree,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
