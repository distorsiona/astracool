import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class SupportCard extends StatelessWidget {
  final Color accentColor;

  final VoidCallback onHelpTap;
  final VoidCallback onAboutTap;

  const SupportCard({
    super.key,
    required this.accentColor,
    required this.onHelpTap,
    required this.onAboutTap,
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
            l10n.supportSectionTitle,
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
                _SupportRow(
                  icon: Icons.help_outline,
                  label: l10n.helpSupportTitle,
                  accentColor: accentColor,
                  onTap: onHelpTap,
                ),

                _SupportRow(
                  icon: Icons.info_outline,
                  label: l10n.aboutSacredTitle,
                  accentColor: accentColor,
                  onTap: onAboutTap,
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

class _SupportRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;

  final VoidCallback onTap;

  final bool showDivider;

  const _SupportRow({
    required this.icon,
    required this.label,
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