import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class ProfileQuoteCard extends StatelessWidget {
  final Color accentColor;

  const ProfileQuoteCard({
    super.key,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 220,
      ),
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: accentColor.withAlpha(12),
        border: Border.all(
          color: accentColor.withAlpha(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 8,
            bottom: 4,
            child: Icon(
              Icons.nightlight_outlined,
              color: accentColor.withAlpha(32),
              size: 100,
            ),
          ),

          Positioned(
            right: 82,
            top: 18,
            child: Icon(
              Icons.auto_awesome,
              color: accentColor.withAlpha(50),
              size: 20,
            ),
          ),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: accentColor,
                    size: 24,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    l10n.quoteLine1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColor,
                      fontFamily: 'serif',
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    l10n.quoteLine2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColor.withAlpha(220),
                      fontFamily: 'serif',
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}