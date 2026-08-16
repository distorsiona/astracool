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
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 650) {
          return _buildMobile();
        }

        return _buildDesktop();
      },
    );
  }

  // ============================================================
  // DESKTOP / TABLET
  // ============================================================

  Widget _buildDesktop() {
    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.symmetric(
        horizontal: 58,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD4D0CA),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // ====================================================
          // LOGO
          // ====================================================

          SizedBox(
            width: 220,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                // TODO: nombre temporal de la app.
                'A S T R A',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 25,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ====================================================
          // NAV CENTRADA
          // ====================================================

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DesktopNavItem(
                  title: 'TODAY',
                  selected:
                      activeSection == AstrologySection.today,
                  accentColor: accentColor,
                  onTap: onToday,
                ),

                const SizedBox(width: 44),

                _DesktopNavItem(
                  title: 'CHART',
                  selected:
                      activeSection == AstrologySection.chart,
                  accentColor: accentColor,
                  onTap: onChart,
                ),

                const SizedBox(width: 44),

                _DesktopNavItem(
                  title: 'WEEK',
                  selected:
                      activeSection == AstrologySection.week,
                  accentColor: accentColor,
                  onTap: onWeek,
                ),

                const SizedBox(width: 44),

                _DesktopNavItem(
                  title: 'ME',
                  selected:
                      activeSection == AstrologySection.profile,
                  accentColor: accentColor,
                  onTap: onProfile,
                ),
              ],
            ),
          ),

          // ====================================================
          // PERFIL
          // ====================================================

          SizedBox(
            width: 220,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onProfile,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: activeSection ==
                              AstrologySection.profile
                          ? accentColor
                          : const Color(0xFF252525),
                      width: activeSection ==
                              AstrologySection.profile
                          ? 1.8
                          : 1.2,
                    ),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 25,
                    color: activeSection ==
                            AstrologySection.profile
                        ? accentColor
                        : const Color(0xFF252525),
                  ),
                ),
              ),
            ),
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
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD4D0CA),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              14,
              18,
              8,
            ),
            child: Row(
              children: [
                Text(
                  'A S T R A',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 17,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                InkWell(
                  onTap: onProfile,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: activeSection ==
                                AstrologySection.profile
                            ? accentColor
                            : const Color(0xFF252525),
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: 20,
                      color: activeSection ==
                              AstrologySection.profile
                          ? accentColor
                          : const Color(0xFF252525),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  _MobileNavItem(
                    title: 'TODAY',
                    selected:
                        activeSection == AstrologySection.today,
                    accentColor: accentColor,
                    onTap: onToday,
                  ),
                  _MobileNavItem(
                    title: 'CHART',
                    selected:
                        activeSection == AstrologySection.chart,
                    accentColor: accentColor,
                    onTap: onChart,
                  ),
                  _MobileNavItem(
                    title: 'WEEK',
                    selected:
                        activeSection == AstrologySection.week,
                    accentColor: accentColor,
                    onTap: onWeek,
                  ),
                  _MobileNavItem(
                    title: 'PROFILE',
                    selected:
                        activeSection == AstrologySection.profile,
                    accentColor: accentColor,
                    onTap: onProfile,
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 92,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                color: selected
                    ? accentColor
                    : const Color(0xFF1E1E1E),
                fontSize: 15,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),

            const SizedBox(height: 9),

            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: selected ? 72 : 0,
              height: 2,
              color: accentColor,
            ),
          ],
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 11,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: selected
                      ? accentColor
                      : const Color(0xFF252525),
                  fontSize: 11,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: selected ? 42 : 0,
              height: 2,
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }
}