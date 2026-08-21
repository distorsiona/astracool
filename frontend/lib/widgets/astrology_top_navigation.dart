import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

// ================================================================
// SECCIONES PRINCIPALES
//
// today   -> TODAY / HOY
// chart   -> CHART / CARTA
// week    -> WEEK / SEMANA
// profile -> ME / YO
// account -> ícono de usuario / Account Settings
//
// account NO aparece como texto en la barra.
// ================================================================

enum AstrologySection {
  today,
  chart,
  week,
  profile,
  account,
}

class AstrologyTopNavigation extends StatelessWidget {
  final AstrologySection activeSection;
  final Color accentColor;

  final VoidCallback? onToday;
  final VoidCallback? onChart;
  final VoidCallback? onWeek;

  // ME / YO
  final VoidCallback? onProfile;

  // ícono de usuario / account settings
  final VoidCallback? onAccountProfile;

  const AstrologyTopNavigation({
    super.key,
    required this.activeSection,
    required this.accentColor,
    this.onToday,
    this.onChart,
    this.onWeek,
    this.onProfile,
    this.onAccountProfile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        final width = constraints.maxWidth;

        if (width < 650) {
          return _buildMobile(context);
        }

        if (width < 1050) {
          return _buildTablet(context);
        }

        return _buildDesktop(context);
      },
    );
  }

  // ==============================================================
  // DESKTOP
  // ==============================================================

  Widget _buildDesktop(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    final accountSelected =
        activeSection == AstrologySection.account;

    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.symmetric(
        horizontal: 42,
      ),
      decoration: _bottomBorderDecoration(),
      child: Row(
        children: [
          // ======================================================
          // LOGO
          // ======================================================

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

          // ======================================================
          // NAVEGACIÓN CENTRAL
          // ======================================================

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DesktopNavItem(
                  title: l10n.navToday,
                  selected:
                      activeSection == AstrologySection.today,
                  accentColor: accentColor,
                  onTap: onToday,
                ),

                const SizedBox(width: 36),

                _DesktopNavItem(
                  title: l10n.navChart,
                  selected:
                      activeSection == AstrologySection.chart,
                  accentColor: accentColor,
                  onTap: onChart,
                ),

                const SizedBox(width: 36),

                _DesktopNavItem(
                  title: l10n.navWeek,
                  selected:
                      activeSection == AstrologySection.week,
                  accentColor: accentColor,
                  onTap: onWeek,
                ),

                const SizedBox(width: 36),

                _DesktopNavItem(
                  title: l10n.navMe,
                  selected:
                      activeSection == AstrologySection.profile,
                  accentColor: accentColor,
                  onTap: onProfile,
                ),
              ],
            ),
          ),

          // ======================================================
          // ACCOUNT SETTINGS
          // ======================================================

          SizedBox(
            width: 180,
            child: Align(
              alignment: Alignment.centerRight,
              child: _AccountButton(
                selected: accountSelected,
                accentColor: accentColor,
                onTap: onAccountProfile,
                size: 44,
                iconSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // TABLET
  // ==============================================================

  Widget _buildTablet(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    final accountSelected =
        activeSection == AstrologySection.account;

    return Container(
      width: double.infinity,
      height: 78,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: _bottomBorderDecoration(),
      child: Row(
        children: [
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

          const SizedBox(width: 16),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _TabletNavItem(
                    title: l10n.navToday,
                    selected:
                        activeSection == AstrologySection.today,
                    accentColor: accentColor,
                    onTap: onToday,
                  ),
                ),

                Expanded(
                  child: _TabletNavItem(
                    title: l10n.navChart,
                    selected:
                        activeSection == AstrologySection.chart,
                    accentColor: accentColor,
                    onTap: onChart,
                  ),
                ),

                Expanded(
                  child: _TabletNavItem(
                    title: l10n.navWeek,
                    selected:
                        activeSection == AstrologySection.week,
                    accentColor: accentColor,
                    onTap: onWeek,
                  ),
                ),

                Expanded(
                  child: _TabletNavItem(
                    title: l10n.navMe,
                    selected:
                        activeSection == AstrologySection.profile,
                    accentColor: accentColor,
                    onTap: onProfile,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          _AccountButton(
            selected: accountSelected,
            accentColor: accentColor,
            onTap: onAccountProfile,
            size: 40,
            iconSize: 23,
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MOBILE
  // ==============================================================

  Widget _buildMobile(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    final accountSelected =
        activeSection == AstrologySection.account;

    return Container(
      width: double.infinity,
      decoration: _bottomBorderDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ======================================================
          // TOP ROW
          // ======================================================

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

                const SizedBox(width: 12),

                _AccountButton(
                  selected: accountSelected,
                  accentColor: accentColor,
                  onTap: onAccountProfile,
                  size: 36,
                  iconSize: 21,
                ),
              ],
            ),
          ),

          // ======================================================
          // NAV
          // ======================================================

          SizedBox(
            height: 46,
            child: Row(
              children: [
                Expanded(
                  child: _MobileNavItem(
                    title: l10n.navToday,
                    selected:
                        activeSection == AstrologySection.today,
                    accentColor: accentColor,
                    onTap: onToday,
                  ),
                ),

                Expanded(
                  child: _MobileNavItem(
                    title: l10n.navChart,
                    selected:
                        activeSection == AstrologySection.chart,
                    accentColor: accentColor,
                    onTap: onChart,
                  ),
                ),

                Expanded(
                  child: _MobileNavItem(
                    title: l10n.navWeek,
                    selected:
                        activeSection == AstrologySection.week,
                    accentColor: accentColor,
                    onTap: onWeek,
                  ),
                ),

                Expanded(
                  child: _MobileNavItem(
                    title: l10n.navMe,
                    selected:
                        activeSection == AstrologySection.profile,
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
// ACCOUNT BUTTON
// ================================================================

class _AccountButton extends StatelessWidget {
  final bool selected;
  final Color accentColor;
  final VoidCallback? onTap;

  final double size;
  final double iconSize;

  const _AccountButton({
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
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            // account activo
            color: selected
                ? accentColor.withAlpha(20)
                : Colors.transparent,

            border: Border.all(
              color: accentColor,
              width: selected ? 2 : 1.3,
            ),
          ),
          child: Icon(
            Icons.person_outline,
            size: iconSize,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}

// ================================================================
// DESKTOP NAV ITEM
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
              const SizedBox(height: 4),

              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  color: selected
                      ? accentColor
                      : const Color(0xFF1E1E1E),
                  fontSize: 14,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),

              const SizedBox(height: 9),

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
// TABLET NAV ITEM
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
                      : const Color(0xFF252525),
                  fontSize: 12,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),

              const SizedBox(height: 8),

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
// MOBILE NAV ITEM
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
                        : const Color(0xFF252525),
                    fontSize: 10.5,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
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
    color: Color(0xFFF4F1EE),
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFD4D0CA),
        width: 1,
      ),
    ),
  );
}