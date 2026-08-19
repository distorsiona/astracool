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
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        final width = constraints.maxWidth;

        // ======================================================
        // MOBILE
        // ======================================================

        if (width < 650) {
          return _buildMobile();
        }

        // ======================================================
        // TABLET / VENTANA MEDIANA
        // ======================================================

        if (width < 1050) {
          return _buildTablet();
        }

        // ======================================================
        // DESKTOP
        // ======================================================

        return _buildDesktop();
      },
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.symmetric(
        horizontal: 42,
      ),
      decoration: _bottomBorderDecoration(),
      child: Row(
        children: [
          // ====================================================
          // LOGO
          // ====================================================

          SizedBox(
            width: 180,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'S A C R E D',
                maxLines: 1,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ====================================================
          // NAV
          // ====================================================

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DesktopNavItem(
                  title: 'TODAY',
                  selected: activeSection == AstrologySection.today,
                  accentColor: accentColor,
                  onTap: onToday,
                ),
                const SizedBox(
                  width: 36,
                ),
                _DesktopNavItem(
                  title: 'CHART',
                  selected: activeSection == AstrologySection.chart,
                  accentColor: accentColor,
                  onTap: onChart,
                ),
                const SizedBox(
                  width: 36,
                ),
                _DesktopNavItem(
                  title: 'WEEK',
                  selected: activeSection == AstrologySection.week,
                  accentColor: accentColor,
                  onTap: onWeek,
                ),
                const SizedBox(
                  width: 36,
                ),
                _DesktopNavItem(
                  title: 'ME',
                  selected: activeSection == AstrologySection.profile,
                  accentColor: accentColor,
                  onTap: onProfile,
                ),
              ],
            ),
          ),

          // ====================================================
          // PROFILE ICON
          // ====================================================

          SizedBox(
            width: 180,
            child: Align(
              alignment: Alignment.centerRight,
              child: _ProfileButton(
                selected: activeSection == AstrologySection.profile,
                accentColor: accentColor,
                onTap: onProfile,
                size: 44,
                iconSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet() {
    return Container(
      width: double.infinity,
      height: 78,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: _bottomBorderDecoration(),
      child: Row(
        children: [
          // ====================================================
          // LOGO MÁS COMPACTO
          // ====================================================

          Text(
            'SACRED',
            maxLines: 1,
            style: TextStyle(
              color: accentColor,
              fontSize: 19,
              letterSpacing: 3.2,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          // ====================================================
          // NAV FLEXIBLE
          // ====================================================

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _TabletNavItem(
                    title: 'TODAY',
                    selected: activeSection == AstrologySection.today,
                    accentColor: accentColor,
                    onTap: onToday,
                  ),
                ),
                Expanded(
                  child: _TabletNavItem(
                    title: 'CHART',
                    selected: activeSection == AstrologySection.chart,
                    accentColor: accentColor,
                    onTap: onChart,
                  ),
                ),
                Expanded(
                  child: _TabletNavItem(
                    title: 'WEEK',
                    selected: activeSection == AstrologySection.week,
                    accentColor: accentColor,
                    onTap: onWeek,
                  ),
                ),
                Expanded(
                  child: _TabletNavItem(
                    title: 'ME',
                    selected: activeSection == AstrologySection.profile,
                    accentColor: accentColor,
                    onTap: onProfile,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          _ProfileButton(
            selected: activeSection == AstrologySection.profile,
            accentColor: accentColor,
            onTap: onProfile,
            size: 38,
            iconSize: 22,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return Container(
      width: double.infinity,
      decoration: _bottomBorderDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ====================================================
          // TOP ROW
          // ====================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              7,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'S A C R E D',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      letterSpacing: 3.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                _ProfileButton(
                  selected: activeSection == AstrologySection.profile,
                  accentColor: accentColor,
                  onTap: onProfile,
                  size: 34,
                  iconSize: 20,
                ),
              ],
            ),
          ),

          // ====================================================
          // NAV - NO SCROLL, SIEMPRE CABE
          // ====================================================

          SizedBox(
            height: 46,
            child: Row(
              children: [
                Expanded(
                  child: _MobileNavItem(
                    title: 'TODAY',
                    selected: activeSection == AstrologySection.today,
                    accentColor: accentColor,
                    onTap: onToday,
                  ),
                ),
                Expanded(
                  child: _MobileNavItem(
                    title: 'CHART',
                    selected: activeSection == AstrologySection.chart,
                    accentColor: accentColor,
                    onTap: onChart,
                  ),
                ),
                Expanded(
                  child: _MobileNavItem(
                    title: 'WEEK',
                    selected: activeSection == AstrologySection.week,
                    accentColor: accentColor,
                    onTap: onWeek,
                  ),
                ),
                Expanded(
                  child: _MobileNavItem(
                    title: 'ME',
                    selected: activeSection == AstrologySection.profile,
                    accentColor: accentColor,
                    onTap: onProfile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PROFILE BUTTON
// ================================================================

class _ProfileButton extends StatelessWidget {
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  final double size;
  final double iconSize;

  const _ProfileButton({
    required this.selected,
    required this.accentColor,
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          999,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? accentColor
                  : const Color(
                      0xFF252525,
                    ),
              width: selected ? 1.8 : 1.1,
            ),
          ),
          child: Icon(
            Icons.person_outline,
            size: iconSize,
            color: selected
                ? accentColor
                : const Color(
                    0xFF252525,
                  ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// DESKTOP ITEM
// ================================================================

class _DesktopNavItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  const _DesktopNavItem({
    required this.title,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 92,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  color: selected
                      ? accentColor
                      : const Color(
                          0xFF1E1E1E,
                        ),
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                width: selected ? 64 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(
                    99,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TABLET ITEM
// ================================================================

class _TabletNavItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  const _TabletNavItem({
    required this.title,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 78,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? accentColor
                      : const Color(
                          0xFF252525,
                        ),
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                width: selected ? 46 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(
                    99,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// MOBILE ITEM
// ================================================================

class _MobileNavItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  const _MobileNavItem({
    required this.title,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? accentColor
                        : const Color(
                            0xFF252525,
                          ),
                    fontSize: 10.5,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              width: selected ? 38 : 0,
              height: 2,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(
                  99,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// DECORATION
// ================================================================

BoxDecoration _bottomBorderDecoration() {
  return const BoxDecoration(
    color: Color(
      0xFFF4F1EE,
    ),
    border: Border(
      bottom: BorderSide(
        color: Color(
          0xFFD4D0CA,
        ),
        width: 1,
      ),
    ),
  );
}
