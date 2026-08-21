import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../l10n/today_labels.dart';
import '../../../models/today_model.dart';
import '../../../theme/card_decorations.dart';
import '../../../utils/astrology_symbols.dart';
import 'today_title_line.dart';

class TransitsCard extends StatelessWidget {
  final List<TodayTransit> transits;
  final Color accentColor;
  final bool mobile;

  const TransitsCard({
    super.key,
    required this.transits,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      child: Padding(
        padding: EdgeInsets.all(mobile ? 20 : 26),
        child: Column(
          children: [
            TodayTitleLine(
              title: l10n.activeTransitsTitle,
              accentColor: accentColor,
            ),
            const SizedBox(height: 20),
            if (transits.isEmpty)
              Text(l10n.noActiveTransitsMessage)
            else
              ...transits.take(4).map(
                    (transit) =>
                        TransitRow(transit: transit, accentColor: accentColor),
                  ),
          ],
        ),
      ),
    );
  }
}

class TransitRow extends StatelessWidget {
  final TodayTransit transit;
  final Color accentColor;

  const TransitRow({
    super.key,
    required this.transit,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: bottomLineDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withAlpha(18),
            ),
            alignment: Alignment.center,
            child: Text(
              '${planetSymbol(transit.first)} ${aspectSymbol(transit.aspect)} '
              '${planetSymbol(transit.second)}',
              style: TextStyle(color: accentColor, fontSize: 19),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Text(
                      localizedTransitTitle(context, transit),
                      style: const TextStyle(
                        color: Color(0xFF251F25),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (transit.status.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withAlpha(18),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          localizedTransitStatus(context, transit)
                              .toUpperCase(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  localizedTransitDescription(context, transit),
                  style: const TextStyle(
                    color: Color(0xFF625961),
                    fontSize: 12.5,
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
