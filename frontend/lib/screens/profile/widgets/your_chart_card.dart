import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../helpers/profile_card_decoration.dart';
import 'mini_chart.dart';

class YourChartCard extends StatelessWidget {
  final Color accentColor;
  final bool mobile;

  final VoidCallback? onTap;

  const YourChartCard({
    super.key,
    required this.accentColor,
    this.mobile = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 20 : 40,
            vertical: mobile ? 22 : 28,
          ),
          decoration: profileCardDecoration(),
          child: mobile ? _buildMobile(context) : _buildDesktop(context),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        MiniChart(color: accentColor, size: 130),
        const SizedBox(width: 42),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.yourChartTitle,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.yourChartDescription,
                style: const TextStyle(color: Color(0xFF252525), fontSize: 15),
              ),
              const SizedBox(height: 24),
              ChartButton(accentColor: accentColor),
            ],
          ),
        ),
        Icon(Icons.auto_awesome, size: 110, color: accentColor.withAlpha(20)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MiniChart(color: accentColor, size: 74),
            const SizedBox(width: 18),
            Text(
              l10n.yourChartTitle,
              style: TextStyle(
                color: accentColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          l10n.yourChartDescription,
          style: const TextStyle(
            color: Color(0xFF252525),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        ChartButton(accentColor: accentColor),
      ],
    );
  }
}

class ChartButton extends StatelessWidget {
  final Color accentColor;

  const ChartButton({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.viewFullChartAction,
          style: TextStyle(
            color: accentColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Icon(Icons.arrow_forward, color: accentColor, size: 20),
      ],
    );
  }
}
