import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class ProfilePrivacyBanner extends StatelessWidget {
  final Color accentColor;

  const ProfilePrivacyBanner({
    super.key,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withAlpha(18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            color: accentColor,
            size: 20,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              AppLocalizations.of(context)!
                  .privacyBannerText,
              style: const TextStyle(
                color: Color(0xFF716871),
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}