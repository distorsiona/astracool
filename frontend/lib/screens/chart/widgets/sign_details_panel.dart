import 'package:flutter/material.dart';

import '../../../models/natal_chart_model.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';

class SignDetailsPanel extends StatelessWidget {
  final ChartProfile profile;
  final Color accentColor;
  final ChartLayout layout;

  const SignDetailsPanel({
    super.key,
    required this.profile,
    required this.accentColor,
    required this.layout,
  });

  bool get isMobile => layout == ChartLayout.mobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 26),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              profile.sign.toUpperCase(),
              style: TextStyle(
                color: accentColor,
                fontFamily: 'serif',
                fontSize: isMobile ? 32 : 38,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: accentColor, width: 4)),
            ),
            child: Column(
              children: [
                ChartDetailRow(
                  icon: Icons.water_drop_outlined,
                  label: 'ELEMENT',
                  value: profile.element,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 19),
                ChartDetailRow(
                  icon: Icons.public_outlined,
                  label: 'RULING PLANET',
                  value: profile.rulingPlanet,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 19),
                ChartDetailRow(
                  icon: Icons.crop_square_outlined,
                  label: 'MODALITY',
                  value: profile.modality,
                  accentColor: accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  const ChartDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accentColor, size: 21),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 9,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value.trim().isEmpty ? '—' : value.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF231729),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
