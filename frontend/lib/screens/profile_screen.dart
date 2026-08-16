import 'package:flutter/material.dart';

import '../models/zodiac_profile_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';
import '../widgets/big_three_card.dart';
import '../widgets/zodiac_profile_header.dart';
import 'chart_screen.dart';


class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  ZodiacProfileModel? profile;

  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    _loadProfile();
  }

  // ============================================================
  // API
  // ============================================================

  Future<void> _loadProfile() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiService.getProfile(
        userId: widget.userId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        profile = result;
        loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
        errorMessage = error.toString();
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return _buildLoading();
    }

    if (errorMessage != null) {
      return _buildError();
    }

    if (profile == null) {
      return _buildError(
        customMessage: 'No fue posible cargar el perfil.',
      );
    }

    final currentProfile = profile!;

    final accentColor = ZodiacTheme.colorForSign(
      currentProfile.sign,
    );

    return Scaffold(
      backgroundColor: ZodiacTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection: AstrologySection.profile,
              accentColor: accentColor,
              onToday: () {},
              onChart: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ChartScreen(
                      userId:
                          widget.userId,
                    ),
                  ),
                );
              },
              onWeek: () {},
              onProfile: () {},
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    final width =
                        constraints.maxWidth;

                    final isMobile =
                        width < 650;

                    final isTablet =
                        width >= 650 &&
                        width < 1100;

                    final horizontalPadding =
                        isMobile
                            ? 14.0
                            : isTablet
                                ? 28.0
                                : 46.0;

                    return Padding(
                      padding:
                          EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isMobile ? 18 : 36,
                        horizontalPadding,
                        40,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(
                            maxWidth: 1540,
                          ),
                          child: isMobile
                              ? _buildMobile(
                                  currentProfile,
                                  accentColor,
                                )
                              : isTablet
                                  ? _buildTablet(
                                      currentProfile,
                                      accentColor,
                                    )
                                  : _buildDesktop(
                                      currentProfile,
                                      accentColor,
                                    ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(
    ZodiacProfileModel profile,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 59,
              child: ZodiacProfileHeader(
                profile: profile,
                accentColor: accentColor,
              ),
            ),

            const SizedBox(width: 26),

            Expanded(
              flex: 41,
              child: BigThreeCard(
                sun: profile.sun,
                moon: profile.moon,
                rising: profile.rising,
                accentColor: accentColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ProfileFeatureCard(
                title: 'TODAY',
                description:
                    'See how today’s transits are influencing your chart.',
                actionText: 'VIEW TODAY',
                icon:
                    Icons.wb_sunny_outlined,
                accentColor:
                    accentColor,
                type:
                    _FeatureType.today,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: _ProfileFeatureCard(
                title: 'ACTIVE TRANSITS',
                description:
                    'The most important transits happening right now.',
                actionText:
                    'VIEW TRANSITS',
                icon:
                    Icons.public_outlined,
                accentColor:
                    accentColor,
                type:
                    _FeatureType.transits,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: _ProfileFeatureCard(
                title: 'THIS WEEK',
                description:
                    'Your astrological forecast for the week ahead.',
                actionText: 'VIEW WEEK',
                icon:
                    Icons.calendar_month_outlined,
                accentColor:
                    accentColor,
                type:
                    _FeatureType.week,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        _YourChartCard(
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet(
    ZodiacProfileModel profile,
    Color accentColor,
  ) {
    return Column(
      children: [
        ZodiacProfileHeader(
          profile: profile,
          accentColor: accentColor,
        ),

        const SizedBox(height: 20),

        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ProfileFeatureCard(
                title: 'TODAY',
                description:
                    'See how today’s transits are influencing your chart.',
                actionText: 'VIEW TODAY',
                icon:
                    Icons.wb_sunny_outlined,
                accentColor:
                    accentColor,
                type:
                    _FeatureType.today,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _ProfileFeatureCard(
                title:
                    'ACTIVE TRANSITS',
                description:
                    'The most important transits happening right now.',
                actionText:
                    'VIEW TRANSITS',
                icon:
                    Icons.public_outlined,
                accentColor:
                    accentColor,
                type:
                    _FeatureType.transits,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _ProfileFeatureCard(
          title: 'THIS WEEK',
          description:
              'Your astrological forecast for the week ahead.',
          actionText: 'VIEW WEEK',
          icon:
              Icons.calendar_month_outlined,
          accentColor: accentColor,
          type: _FeatureType.week,
        ),

        const SizedBox(height: 16),

        _YourChartCard(
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(
    ZodiacProfileModel profile,
    Color accentColor,
  ) {
    return Column(
      children: [
        ZodiacProfileHeader(
          profile: profile,
          accentColor: accentColor,
        ),

        const SizedBox(height: 16),

        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),

        const SizedBox(height: 16),

        _ProfileFeatureCard(
          title: 'TODAY',
          description:
              'See how today’s transits are influencing your chart.',
          actionText: 'VIEW TODAY',
          icon:
              Icons.wb_sunny_outlined,
          accentColor: accentColor,
          type: _FeatureType.today,
          mobile: true,
        ),

        const SizedBox(height: 14),

        _ProfileFeatureCard(
          title: 'ACTIVE TRANSITS',
          description:
              'The most important transits happening right now.',
          actionText:
              'VIEW TRANSITS',
          icon:
              Icons.public_outlined,
          accentColor: accentColor,
          type: _FeatureType.transits,
          mobile: true,
        ),

        const SizedBox(height: 14),

        _ProfileFeatureCard(
          title: 'THIS WEEK',
          description:
              'Your astrological forecast for the week ahead.',
          actionText: 'VIEW WEEK',
          icon:
              Icons.calendar_month_outlined,
          accentColor: accentColor,
          type: _FeatureType.week,
          mobile: true,
        ),

        const SizedBox(height: 14),

        _YourChartCard(
          accentColor: accentColor,
          mobile: true,
        ),
      ],
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading() {
    return Scaffold(
      backgroundColor:
          ZodiacTheme.background,
      body: const Center(
        child:
            CircularProgressIndicator(),
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError({
    String? customMessage,
  }) {
    return Scaffold(
      backgroundColor:
          ZodiacTheme.background,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 46,
              ),

              const SizedBox(height: 16),

              Text(
                customMessage ??
                    errorMessage ??
                    'Error desconocido.',
                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(height: 20),

              FilledButton(
                onPressed: _loadProfile,
                child:
                    const Text(
                  'Reintentar',
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
// FEATURE TYPE
// ================================================================

enum _FeatureType {
  today,
  transits,
  week,
}


// ================================================================
// FEATURE CARD
// ================================================================

class _ProfileFeatureCard
    extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;

  final IconData icon;
  final Color accentColor;
  final _FeatureType type;

  final bool mobile;
  final double minHeight;

  const _ProfileFeatureCard({
    required this.title,
    required this.description,
    required this.actionText,
    required this.icon,
    required this.accentColor,
    required this.type,
    this.mobile = false,
    this.minHeight = 210,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight:
            mobile
                ? 165
                : minHeight,
      ),
      padding: EdgeInsets.all(
        mobile ? 18 : 28,
      ),
      decoration: BoxDecoration(
        color:
            Colors.white.withAlpha(25),
        border: Border.all(
          color:
              const Color(
            0xFFD6D2CB,
          ),
        ),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -30,
            child: IgnorePointer(
              child: _CardDecoration(
                type: type,
                color:
                    accentColor.withAlpha(45),
              ),
            ),
          ),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: accentColor,
                size:
                    mobile
                        ? 37
                        : 52,
              ),

              SizedBox(
                width:
                    mobile
                        ? 14
                        : 24,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: accentColor,
                        fontSize:
                            mobile
                                ? 13
                                : 17,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ConstrainedBox(
                      constraints:
                          BoxConstraints(
                        maxWidth:
                            mobile
                                ? 260
                                : 250,
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          color:
                              const Color(
                            0xFF252525,
                          ),
                          fontSize:
                              mobile
                                  ? 13
                                  : 15,
                          height: 1.55,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        Text(
                          actionText,
                          style: TextStyle(
                            color:
                                accentColor,
                            fontSize:
                                mobile
                                    ? 12
                                    : 14,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color:
                              accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ================================================================
// DECORACIÓN
// ================================================================

class _CardDecoration
    extends StatelessWidget {
  final _FeatureType type;
  final Color color;

  const _CardDecoration({
    required this.type,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    switch (type) {
      case _FeatureType.today:
        return Icon(
          Icons.blur_circular,
          size: 170,
          color: color,
        );

      case _FeatureType.transits:
        return Transform.rotate(
          angle: .5,
          child: Icon(
            Icons.all_inclusive,
            size: 170,
            color: color,
          ),
        );

      case _FeatureType.week:
        return Icon(
          Icons.auto_awesome,
          size: 155,
          color: color,
        );
    }
  }
}


// ================================================================
// YOUR CHART
// ================================================================

class _YourChartCard
    extends StatelessWidget {
  final Color accentColor;
  final bool mobile;

  const _YourChartCard({
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal:
            mobile ? 20 : 40,
        vertical:
            mobile ? 22 : 28,
      ),
      decoration: BoxDecoration(
        color:
            Colors.white.withAlpha(25),
        border: Border.all(
          color:
              const Color(
            0xFFD6D2CB,
          ),
        ),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child:
          mobile
              ? _buildMobile()
              : _buildDesktop(),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        _MiniChart(
          color: accentColor,
          size: 130,
        ),

        const SizedBox(width: 42),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'YOUR CHART',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 19,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Explore your natal chart, planets, houses and aspects in detail.',
                style: TextStyle(
                  color:
                      Color(
                    0xFF252525,
                  ),
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 24),

              _ChartButton(
                accentColor:
                    accentColor,
              ),
            ],
          ),
        ),

        Icon(
          Icons.auto_awesome,
          size: 110,
          color:
              accentColor.withAlpha(20),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _MiniChart(
              color: accentColor,
              size: 74,
            ),

            const SizedBox(width: 18),

            Text(
              'YOUR CHART',
              style: TextStyle(
                color: accentColor,
                fontSize: 15,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        const Text(
          'Explore your natal chart, planets, houses and aspects in detail.',
          style: TextStyle(
            color:
                Color(
              0xFF252525,
            ),
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 18),

        _ChartButton(
          accentColor:
              accentColor,
        ),
      ],
    );
  }
}


// ================================================================
// CHART BUTTON
// ================================================================

class _ChartButton
    extends StatelessWidget {
  final Color accentColor;

  const _ChartButton({
    required this.accentColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisSize:
          MainAxisSize.min,
      children: [
        Text(
          'VIEW FULL CHART',
          style: TextStyle(
            color: accentColor,
            fontSize: 14,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(width: 10),

        Icon(
          Icons.arrow_forward,
          color: accentColor,
          size: 20,
        ),
      ],
    );
  }
}


// ================================================================
// MINI CARTA ASTRAL
// ================================================================

class _MiniChart
    extends StatelessWidget {
  final Color color;
  final double size;

  const _MiniChart({
    required this.color,
    required this.size,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MiniChartPainter(
          color: color,
        ),
      ),
    );
  }
}


// ================================================================
// MINI CHART PAINTER
// ================================================================

class _MiniChartPainter
    extends CustomPainter {
  final Color color;

  _MiniChartPainter({
    required this.color,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..color =
              color
          ..style =
              PaintingStyle.stroke
          ..strokeWidth =
              1;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        size.shortestSide / 2 - 2;

    canvas.drawCircle(
      center,
      radius,
      paint,
    );

    canvas.drawCircle(
      center,
      radius * .68,
      paint,
    );

    for (int i = 0; i < 12; i++) {
      final angle =
          i *
              30 *
              3.1415926535 /
              180;

      final outer = Offset(
        center.dx +
            radius *
                _cos(angle),
        center.dy +
            radius *
                _sin(angle),
      );

      final inner = Offset(
        center.dx +
            radius *
                .68 *
                _cos(angle),
        center.dy +
            radius *
                .68 *
                _sin(angle),
      );

      canvas.drawLine(
        inner,
        outer,
        paint,
      );
    }

    canvas.drawLine(
      Offset(
        center.dx -
            radius * .6,
        center.dy,
      ),
      Offset(
        center.dx +
            radius * .5,
        center.dy -
            radius * .4,
      ),
      paint,
    );

    canvas.drawLine(
      Offset(
        center.dx,
        center.dy -
            radius * .6,
      ),
      Offset(
        center.dx +
            radius * .5,
        center.dy +
            radius * .5,
      ),
      paint,
    );
  }

  double _sin(
    double value,
  ) {
    double term = value;
    double result = value;

    for (int n = 1; n < 10; n++) {
      term *=
          -value *
              value /
              ((2 * n) *
                  (2 * n + 1));

      result += term;
    }

    return result;
  }

  double _cos(
    double value,
  ) {
    double term = 1;
    double result = 1;

    for (int n = 1; n < 10; n++) {
      term *=
          -value *
              value /
              ((2 * n - 1) *
                  (2 * n));

      result += term;
    }

    return result;
  }

  @override
  bool shouldRepaint(
    covariant _MiniChartPainter oldDelegate,
  ) {
    return oldDelegate.color !=
        color;
  }
}