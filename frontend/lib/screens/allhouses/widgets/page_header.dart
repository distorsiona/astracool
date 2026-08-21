import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class PageHeader extends StatelessWidget {
  final Color accentColor;
  final bool isMobile;
  final bool isTablet;

  const PageHeader({
    super.key,
    required this.accentColor,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.yourNatalHousesEyebrow,
          style: TextStyle(
            color: accentColor,
            fontSize: 11,
            letterSpacing: 2.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.twelveHousesTitle,
          style: TextStyle(
            color: accentColor,
            fontFamily: 'serif',
            fontSize: isMobile ? 30 : (isTablet ? 35 : 40),
            height: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 760,
          ),
          child: Text(
            l10n.twelveHousesDescription,
            style: const TextStyle(
              color: Color(0xFF6F626E),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
