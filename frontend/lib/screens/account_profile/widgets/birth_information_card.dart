import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class BirthInformationCard extends StatelessWidget {
  final Color accentColor;

  final String dateOfBirth;
  final String timeOfBirth;
  final String birthPlace;

  const BirthInformationCard({
    super.key,
    required this.accentColor,
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.birthPlace,
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
            title: l10n.birthInformationTitle,
            accentColor: accentColor,
          ),

          const SizedBox(height: 12),

          Text(
            l10n.birthInformationNote,
            style: const TextStyle(
              color: Color(0xFF817780),
              fontSize: 11,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 18),

          _InfoContainer(
            children: [
              _InfoRow(
                icon: Icons.calendar_month_outlined,
                label: l10n.fieldBirthDateLabel,
                value: dateOfBirth,
                accentColor: accentColor,
              ),
              _InfoRow(
                icon: Icons.schedule_outlined,
                label: l10n.fieldBirthTimeLabel,
                value: timeOfBirth,
                accentColor: accentColor,
              ),
              _InfoRow(
                icon: Icons.location_on_outlined,
                label: l10n.birthPlaceLabel,
                value: birthPlace,
                accentColor: accentColor,
                showDivider: false,
              ),
            ],
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

class _InfoContainer extends StatelessWidget {
  final List<Widget> children;

  const _InfoContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E0DC),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final bool showDivider;

  const _InfoRow({
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
        minHeight: 58,
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
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Row(
        children: [
          _IconBox(
            icon: icon,
            accentColor: accentColor,
          ),

          const SizedBox(width: 12),

          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF332C32),
                fontSize: 11.5,
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

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color accentColor;

  const _IconBox({
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
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