import 'package:flutter/material.dart';

enum AstrologySection {
  today,
  chart,
  week,
  profile,
}

class AstrologyTopNavigation extends StatelessWidget {
  final AstrologySection activeSection;
  final Color accentColor;
  final VoidCallback? onToday;
  final VoidCallback? onChart;
  final VoidCallback? onWeek;
  final VoidCallback? onProfile;

  const AstrologyTopNavigation({
    super.key,
    required this.activeSection,
    required this.accentColor,
    this.onToday,
    this.onChart,
    this.onWeek,
    this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        // TODO: Cambiar nombre definitivo de la aplicación.
        Text(
          'ASTRA',
          style: TextStyle(
            color: accentColor,
            fontSize: 22,
            letterSpacing: 8,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        _NavItem(
          text: 'TODAY',
          selected: activeSection == AstrologySection.today,
          accentColor: accentColor,
          onTap: onToday,
        ),
        const SizedBox(width: 34),

        _NavItem(
          text: 'CHART',
          selected: activeSection == AstrologySection.chart,
          accentColor: accentColor,
          onTap: onChart,
        ),
        const SizedBox(width: 34),

        _NavItem(
          text: 'WEEK',
          selected: activeSection == AstrologySection.week,
          accentColor: accentColor,
          onTap: onWeek,
        ),
        const SizedBox(width: 34),

        _NavItem(
          text: 'PROFILE',
          selected: activeSection == AstrologySection.profile,
          accentColor: accentColor,
          onTap: onProfile,
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String text;
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  const _NavItem({
    required this.text,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: selected
                    ? accentColor
                    : const Color(0xFF202020),
                fontSize: 14,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 7),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: selected ? 42 : 0,
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }
}