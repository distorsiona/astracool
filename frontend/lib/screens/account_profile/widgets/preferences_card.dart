import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class PreferencesCard extends StatelessWidget {
  final Color accentColor;

  final String language;
  final String theme;

  final bool notificationsEnabled;

  final VoidCallback onLanguageTap;
  final VoidCallback onThemeTap;
  final VoidCallback onNotificationsTap;

  const PreferencesCard({
    super.key,
    required this.accentColor,
    required this.language,
    required this.theme,
    required this.notificationsEnabled,
    required this.onLanguageTap,
    required this.onThemeTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.preferencesSectionTitle,
            style: TextStyle(
              color: accentColor,
              fontSize: 10.5,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE5E0DC),
              ),
            ),
            child: Column(
              children: [
                _PreferenceRow(
                  icon: Icons.language,
                  label: l10n.languageLabel,
                  value: language,
                  accentColor: accentColor,
                  onTap: onLanguageTap,
                ),

                _PreferenceRow(
                  icon: Icons.palette_outlined,
                  label: l10n.themeLabel,
                  value: theme,
                  accentColor: accentColor,
                  onTap: onThemeTap,
                ),

                _PreferenceRow(
                  icon: Icons.notifications_none_outlined,
                  label: l10n.notificationsLabel,
                  value: notificationsEnabled
                      ? l10n.onLabel
                      : l10n.offLabel,
                  accentColor: accentColor,
                  onTap: onNotificationsTap,
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  final VoidCallback onTap;

  final bool showDivider;

  const _PreferenceRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 64,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(
                  bottom: BorderSide(
                    color: Color(0xFFEAE5E1),
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accentColor.withAlpha(17),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 18,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF332C32),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF716871),
                fontSize: 11.5,
              ),
            ),

            const SizedBox(width: 12),

            Icon(
              Icons.chevron_right,
              color: accentColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white.withAlpha(225),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
      color: const Color(0xFFE5E0DC),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(8),
        blurRadius: 22,
        offset: const Offset(0, 8),
      ),
    ],
  );
}