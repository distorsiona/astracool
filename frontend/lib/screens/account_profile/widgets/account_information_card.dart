import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class AccountInformationCard extends StatelessWidget {
  final Color accentColor;

  final String email;
  final String username;
  final String memberSince;

  const AccountInformationCard({
    super.key,
    required this.accentColor,
    required this.email,
    required this.username,
    required this.memberSince,
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
          _SectionTitle(
            title: l10n.accountSectionTitle,
            accentColor: accentColor,
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
                _AccountRow(
                  icon: Icons.mail_outline,
                  label: l10n.fieldEmailLabel,
                  value: email,
                  accentColor: accentColor,
                ),
                _AccountRow(
                  icon: Icons.person_outline,
                  label: l10n.fieldUsernameLabel,
                  value: username,
                  accentColor: accentColor,
                ),
                _AccountRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.memberSinceLabel,
                  value: memberSince,
                  accentColor: accentColor,
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

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color accentColor;

  const _SectionTitle({
    required this.title,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: accentColor,
        fontSize: 10.5,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final bool showDivider;

  const _AccountRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              size: 18,
              color: accentColor,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            flex: 3,
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

          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF716871),
                fontSize: 11.5,
              ),
            ),
          ),
        ],
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