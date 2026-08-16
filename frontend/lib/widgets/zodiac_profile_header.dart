import 'package:flutter/material.dart';

import '../models/zodiac_profile_model.dart';
import '../theme/zodiac_theme.dart';
import 'zodiac_attribute_item.dart';

class ZodiacProfileHeader extends StatelessWidget {
  final ZodiacProfileModel profile;
  final Color accentColor;

  const ZodiacProfileHeader({
    super.key,
    required this.profile,
    required this.accentColor,
  });

  // =========================================================
  // ELEMENT
  // =========================================================

  IconData _getElementIcon() {
    switch (profile.element) {
      case ZodiacElement.fire:
        return Icons.local_fire_department_outlined;

      case ZodiacElement.earth:
        return Icons.landscape_outlined;

      case ZodiacElement.air:
        return Icons.air;

      case ZodiacElement.water:
        return Icons.water_drop_outlined;
    }
  }

  String _getElementName() {
    switch (profile.element) {
      case ZodiacElement.fire:
        return 'Fire';

      case ZodiacElement.earth:
        return 'Earth';

      case ZodiacElement.air:
        return 'Air';

      case ZodiacElement.water:
        return 'Water';
    }
  }

  String _getModalityName() {
    switch (profile.modality) {
      case ZodiacModality.cardinal:
        return 'Cardinal';

      case ZodiacModality.fixed:
        return 'Fixed';

      case ZodiacModality.mutable:
        return 'Mutable';
    }
  }

  // =========================================================
  // SYMBOL
  // =========================================================

  Widget _buildSymbol({
    required double width,
    required double height,
    required double fallbackSize,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/signs/${profile.sign.toLowerCase().trim()}.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Center(
            child: Text(
              profile.symbol,
              style: TextStyle(
                color: accentColor,
                fontSize: fallbackSize,
                height: 1,
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // RESPONSIVE
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return _buildMobile();
        }

        if (width < 1100) {
          return _buildTablet();
        }

        return _buildDesktop();
      },
    );
  }

  // =========================================================
  // DESKTOP
  // =========================================================

  Widget _buildDesktop() {
    return Container(
      width: double.infinity,
      height: 440,
      padding: const EdgeInsets.fromLTRB(
        36,
        34,
        34,
        34,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(
            0xFFD0D0CA,
          ),
        ),
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // =================================================
          // BARRA IZQUIERDA
          // =================================================

          Container(
            width: 28,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(
                999,
              ),
            ),
          ),

          const SizedBox(
            width: 36,
          ),

          // =================================================
          // INFORMACIÓN
          // =================================================

          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SIGNO

                Text(
                  profile.sign.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: accentColor,
                    fontFamily: ZodiacTheme.fontSignName,
                    fontSize: 58,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                // FECHA

                Text(
                  profile.dateRange,
                  style: const TextStyle(
                    color: Color(
                      0xFF202020,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: .2,
                  ),
                ),

                const Spacer(),

                // ATRIBUTOS

                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: _buildAttributes(
                    iconSize: 34,
                    gap: 30,
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          // =================================================
          // SIGNO GRANDE
          // =================================================

          Expanded(
            flex: 5,
            child: Center(
              child: Transform.scale(
                scale: 1.15,
                child: _buildSymbol(
                  width: 340,
                  height: 340,
                  fallbackSize: 260,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TABLET
    // =========================================================

      Widget _buildTablet() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D0CA),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 18,
            height: 300,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),

          const SizedBox(width: 22),

          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.sign.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: accentColor,
                    fontFamily: ZodiacTheme.fontSignName,
                    fontSize: 44,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    height: 1,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  profile.dateRange,
                  style: const TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                _buildAttributes(
                  iconSize: 30,
                  gap: 20,
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            flex: 4,
            child: Center(
              child: _buildSymbol(
                width: 270,
                height: 300,
                fallbackSize: 180,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // =========================================================
  // MOBILE
  // =========================================================

  Widget _buildMobile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        22,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(
            0xFFD0D0CA,
          ),
        ),
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: Column(
        children: [
          // =================================================
          // HEADER
          // =================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10,
                height: 124,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(
                    999,
                  ),
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              // NOMBRE / FECHA

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.sign.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: accentColor,
                        fontFamily: ZodiacTheme.fontSignName,
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                        height: 1,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      profile.dateRange,
                      style: const TextStyle(
                        color: Color(
                          0xFF202020,
                        ),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 8,
              ),

              // SIGNO

              _buildSymbol(
                width: 140,
                height: 140,
                fallbackSize: 110,
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          Divider(
            color: accentColor.withAlpha(
              90,
            ),
            height: 1,
          ),

          const SizedBox(
            height: 22,
          ),

          // =================================================
          // ATRIBUTOS
          // =================================================

          _buildAttributes(
            iconSize: 28,
            gap: 18,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ATTRIBUTES
  // =========================================================

  Widget _buildAttributes({
    required double iconSize,
    required double gap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZodiacAttributeItem(
          icon: Icon(
            _getElementIcon(),
            color: accentColor,
            size: iconSize,
          ),
          title: 'Element',
          value: _getElementName(),
          accentColor: accentColor,
        ),

        SizedBox(
          height: gap,
        ),

        ZodiacAttributeItem(
          icon: Icon(
            Icons.circle_outlined,
            color: accentColor,
            size: iconSize,
          ),
          title: 'Ruling Planet',
          value: profile.rulingPlanet,
          accentColor: accentColor,
        ),

        SizedBox(
          height: gap,
        ),

        ZodiacAttributeItem(
          icon: Icon(
            Icons.crop_square,
            color: accentColor,
            size: iconSize,
          ),
          title: 'Modality',
          value: _getModalityName(),
          accentColor: accentColor,
        ),
      ],
    );
  }
}