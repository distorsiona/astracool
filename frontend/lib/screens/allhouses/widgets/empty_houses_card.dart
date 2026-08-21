import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/card_decorations.dart';

class EmptyHousesCard extends StatelessWidget {
  final Color accentColor;

  const EmptyHousesCard({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome_outlined, color: accentColor, size: 30),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.noHouseInfoMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
