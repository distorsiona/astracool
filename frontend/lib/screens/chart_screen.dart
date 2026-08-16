import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/natal_chart_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';
import 'profile_screen.dart';


class ChartScreen extends StatefulWidget {
  final String userId;

  const ChartScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ChartScreen> createState() =>
      _ChartScreenState();
}


class _ChartScreenState extends State<ChartScreen> {
  NatalChartModel? natalChart;

  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadChart();
  }

  // ============================================================
  // API
  // ============================================================

  Future<void> _loadChart() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiService.getChart(
        userId: widget.userId,
      );

      if (!mounted) return;

      setState(() {
        natalChart = result;
        loading = false;
      });
    } catch (error) {
      if (!mounted) return;

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

    final data = natalChart;

    if (data == null) {
      return _buildError(
        customMessage:
            'No fue posible cargar tu carta natal.',
      );
    }

    final accentColor =
        ZodiacTheme.colorForSign(
      data.profile.sign,
    );

    final width =
        MediaQuery.sizeOf(context).width;

    final isMobile =
        width < 700;

    final isTablet =
        width >= 700 &&
        width < 1100;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection:
                  AstrologySection.chart,
              accentColor:
                  accentColor,
              onToday: () {},
              onChart: () {},
              onWeek: () {},
              onProfile: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfileScreen(
                      userId:
                          widget.userId,
                    ),
                  ),
                );
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.fromLTRB(
                  isMobile
                      ? 14
                      : isTablet
                          ? 24
                          : 40,
                  isMobile
                      ? 18
                      : 28,
                  isMobile
                      ? 14
                      : isTablet
                          ? 24
                          : 40,
                  44,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(
                      maxWidth: 1200,
                    ),
                    child:
                        isMobile
                            ? _buildMobile(
                                data,
                                accentColor,
                              )
                            : isTablet
                                ? _buildTablet(
                                    data,
                                    accentColor,
                                  )
                                : _buildDesktop(
                                    data,
                                    accentColor,
                                  ),
                  ),
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
    NatalChartModel data,
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
            // ==================================================
            // LEFT
            // ==================================================

            Expanded(
              flex: 67,
              child: Column(
                children: [
                  _ChartWheelCard(
                    data: data,
                    accentColor:
                        accentColor,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _FeaturedHouses(
                    houses:
                        data.chart.houses,
                    accentColor:
                        accentColor,
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 20,
            ),

            // ==================================================
            // RIGHT
            // ==================================================

            Expanded(
              flex: 33,
              child: Column(
                children: [
                  _BigThreePanel(
                    bigThree:
                        data.chart.bigThree,
                    accentColor:
                        accentColor,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _SignDetailsPanel(
                    profile:
                        data.profile,
                    accentColor:
                        accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 26,
        ),

        _PlanetsSection(
          planets:
              data.chart.planets,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 22,
        ),

        _HousesGrid(
          houses:
              data.chart.houses,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 22,
        ),

        _AspectsSection(
          aspects:
              data.chart.aspects,
          accentColor:
              accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet(
    NatalChartModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _ChartWheelCard(
          data: data,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 18,
        ),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  _BigThreePanel(
                bigThree:
                    data.chart.bigThree,
                accentColor:
                    accentColor,
              ),
            ),

            const SizedBox(
              width: 18,
            ),

            Expanded(
              child:
                  _SignDetailsPanel(
                profile:
                    data.profile,
                accentColor:
                    accentColor,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 18,
        ),

        _FeaturedHouses(
          houses:
              data.chart.houses,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 22,
        ),

        _PlanetsSection(
          planets:
              data.chart.planets,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 22,
        ),

        _HousesGrid(
          houses:
              data.chart.houses,
          accentColor:
              accentColor,
        ),

        const SizedBox(
          height: 22,
        ),

        _AspectsSection(
          aspects:
              data.chart.aspects,
          accentColor:
              accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(
    NatalChartModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _ChartWheelCard(
          data: data,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 16,
        ),

        // ======================================================
        // BIG THREE SIEMPRE VA AQUÍ
        // ======================================================

        _BigThreePanel(
          bigThree:
              data.chart.bigThree,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 16,
        ),

        _SignDetailsPanel(
          profile:
              data.profile,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 16,
        ),

        _FeaturedHouses(
          houses:
              data.chart.houses,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 20,
        ),

        _PlanetsSection(
          planets:
              data.chart.planets,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 20,
        ),

        _HousesGrid(
          houses:
              data.chart.houses,
          accentColor:
              accentColor,
          mobile: true,
        ),

        const SizedBox(
          height: 20,
        ),

        _AspectsSection(
          aspects:
              data.chart.aspects,
          accentColor:
              accentColor,
          mobile: true,
        ),
      ],
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading() {
    return const Scaffold(
      backgroundColor:
          Color(0xFFF4F1EE),
      body: Center(
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
          const Color(0xFFF4F1EE),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(
            24,
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                customMessage ??
                    errorMessage ??
                    'Error desconocido.',
                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(
                height: 20,
              ),

              FilledButton(
                onPressed:
                    _loadChart,
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
// CHART WHEEL CARD
// ================================================================

class _ChartWheelCard
    extends StatelessWidget {
  final NatalChartModel data;
  final Color accentColor;
  final bool mobile;

  const _ChartWheelCard({
    required this.data,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width:
          double.infinity,
      padding:
          EdgeInsets.fromLTRB(
        mobile ? 16 : 26,
        mobile ? 20 : 24,
        mobile ? 16 : 26,
        mobile ? 22 : 28,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Text(
            'Your Celestial Blueprint',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color:
                  accentColor,
              fontFamily:
                  'serif',
              fontSize:
                  mobile
                      ? 20
                      : 24,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          SizedBox(
            height:
                mobile
                    ? 18
                    : 24,
          ),

          LayoutBuilder(
            builder: (
              context,
              constraints,
            ) {
              final max =
                  constraints.maxWidth;

              final chartSize =
                  mobile
                      ? math.min(
                          max,
                          340.0,
                        )
                      : math.min(
                          max * .72,
                          470.0,
                        );

              return Center(
                child: SizedBox(
                  width:
                      chartSize,
                  height:
                      chartSize,
                  child:
                      CustomPaint(
                    painter:
                        _NatalWheelPainter(
                      houses:
                          data
                              .chart
                              .houses,
                      planets:
                          data
                              .chart
                              .planets,
                      aspects:
                          data
                              .chart
                              .aspects,
                      accentColor:
                          accentColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// ================================================================
// BIG THREE
// ================================================================

class _BigThreePanel extends StatelessWidget {
  final BigThreeData bigThree;
  final Color accentColor;
  final bool mobile;

  const _BigThreePanel({
    required this.bigThree,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ====================================================
          // LÍNEA SUPERIOR DEL COLOR DEL SIGNO
          // ====================================================

          Container(
            width: double.infinity,
            height: 4,
            color: accentColor,
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              mobile ? 18 : 22,
              mobile ? 16 : 18,
              mobile ? 18 : 22,
              mobile ? 20 : 22,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ==============================================
                // TITLE
                // ==============================================

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: accentColor.withAlpha(
                          65,
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        'YOUR BIG THREE',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 10,
                          letterSpacing: 2,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        color: accentColor.withAlpha(
                          65,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // ==============================================
                // SUN
                // ==============================================

                _BigThreeRow(
                  symbol: '☉',
                  title: 'SUN',
                  placement: bigThree.sun,
                  accentColor: accentColor,
                ),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Divider(
                    height: 1,
                    color: Color(
                      0xFFE9E0E8,
                    ),
                  ),
                ),

                // ==============================================
                // MOON
                // ==============================================

                _BigThreeRow(
                  symbol: '☾',
                  title: 'MOON',
                  placement: bigThree.moon,
                  accentColor: accentColor,
                ),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Divider(
                    height: 1,
                    color: Color(
                      0xFFE9E0E8,
                    ),
                  ),
                ),

                // ==============================================
                // RISING
                // ==============================================

                _BigThreeRow(
                  symbol: '↑',
                  title: 'RISING',
                  placement: bigThree.rising,
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


class _BigThreeRow
    extends StatelessWidget {
  final String symbol;
  final String title;
  final ChartPlacement placement;
  final Color accentColor;

  const _BigThreeRow({
    required this.symbol,
    required this.title,
    required this.placement,
    required this.accentColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final sign =
        placement.sign
                .trim()
                .isEmpty
            ? '—'
            : placement.sign
                .toUpperCase();

    return Row(
      children: [
        SizedBox(
          width: 82,
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Text(
                symbol,
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontSize: 27,
                  height: 1,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(
                title,
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontSize: 9,
                  letterSpacing:
                      1.6,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Expanded(
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Text(
                sign,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                textAlign:
                    TextAlign.center,
                style:
                    const TextStyle(
                  color:
                      Color(
                    0xFF231729,
                  ),
                  fontFamily:
                      'serif',
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                '${placement.degree.toStringAsFixed(2)}°',
                style:
                    const TextStyle(
                  color:
                      Color(
                    0xFF817380,
                  ),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// ================================================================
// SIGN DETAILS
// ================================================================

class _SignDetailsPanel
    extends StatelessWidget {
  final ChartProfile profile;
  final Color accentColor;
  final bool mobile;

  const _SignDetailsPanel({
    required this.profile,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width:
          double.infinity,
      padding:
          EdgeInsets.all(
        mobile ? 22 : 26,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            profile.sign
                .toUpperCase(),
            style:
                TextStyle(
              color:
                  accentColor,
              fontFamily:
                  'serif',
              fontSize:
                  mobile
                      ? 34
                      : 38,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 22,
          ),

          Container(
            padding:
                const EdgeInsets.only(
              left: 18,
            ),
            decoration:
                BoxDecoration(
              border: Border(
                left:
                    BorderSide(
                  color:
                      accentColor,
                  width: 4,
                ),
              ),
            ),
            child: Column(
              children: [
                _DetailRow(
                  icon:
                      Icons
                          .water_drop_outlined,
                  label:
                      'ELEMENT',
                  value:
                      profile.element,
                  accentColor:
                      accentColor,
                ),

                const SizedBox(
                  height: 19,
                ),

                _DetailRow(
                  icon:
                      Icons.public_outlined,
                  label:
                      'RULING PLANET',
                  value:
                      profile.rulingPlanet,
                  accentColor:
                      accentColor,
                ),

                const SizedBox(
                  height: 19,
                ),

                _DetailRow(
                  icon:
                      Icons
                          .crop_square_outlined,
                  label:
                      'MODALITY',
                  value:
                      profile.modality,
                  accentColor:
                      accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _DetailRow
    extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color:
              accentColor,
          size: 21,
        ),

        const SizedBox(
          width: 13,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontSize: 9,
                  letterSpacing:
                      1.4,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                value
                        .trim()
                        .isEmpty
                    ? '—'
                    : value
                        .toUpperCase(),
                style:
                    const TextStyle(
                  color:
                      Color(
                    0xFF231729,
                  ),
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// ================================================================
// FEATURED HOUSES
// ================================================================

class _FeaturedHouses
    extends StatelessWidget {
  final List<ChartHouse> houses;
  final Color accentColor;
  final bool mobile;

  const _FeaturedHouses({
    required this.houses,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final house1 =
        _findHouse(
      houses,
      1,
    );

    final house4 =
        _findHouse(
      houses,
      4,
    );

    if (house1 == null &&
        house4 == null) {
      return const SizedBox
          .shrink();
    }

    if (mobile) {
      return Column(
        children: [
          if (house1 != null)
            _FeaturedHouseCard(
              house:
                  house1,
              accentColor:
                  accentColor,
            ),

          if (house1 != null &&
              house4 != null)
            const SizedBox(
              height: 14,
            ),

          if (house4 != null)
            _FeaturedHouseCard(
              house:
                  house4,
              accentColor:
                  accentColor,
            ),
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        if (house1 != null)
          Expanded(
            child:
                _FeaturedHouseCard(
              house:
                  house1,
              accentColor:
                  accentColor,
            ),
          ),

        if (house1 != null &&
            house4 != null)
          const SizedBox(
            width: 18,
          ),

        if (house4 != null)
          Expanded(
            child:
                _FeaturedHouseCard(
              house:
                  house4,
              accentColor:
                  accentColor,
            ),
          ),
      ],
    );
  }
}


class _FeaturedHouseCard
    extends StatelessWidget {
  final ChartHouse house;
  final Color accentColor;

  const _FeaturedHouseCard({
    required this.house,
    required this.accentColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final first =
        house.number == 1;

    final fourth =
        house.number == 4;

    final title =
        first
            ? 'HOUSE OF SELF'
            : fourth
                ? 'HOUSE OF HOME'
                : 'HOUSE ${house.number}';

    return Container(
      width:
          double.infinity,
      constraints:
          const BoxConstraints(
        minHeight: 140,
      ),
      padding:
          const EdgeInsets.all(
        18,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _ordinal(
                  house.number,
                ),
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontFamily:
                      'serif',
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(
                width: 8,
              ),

              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF4F434F,
                    ),
                    fontSize: 9,
                    letterSpacing:
                        1.3,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 13,
          ),

          Row(
            children: [
              Icon(
                first
                    ? Icons
                        .arrow_upward
                    : Icons
                        .bed_outlined,
                size: 17,
                color:
                    accentColor,
              ),

              const SizedBox(
                width: 8,
              ),

              Expanded(
                child: Text(
                  first
                      ? '${house.sign} Rising'
                      : fourth
                          ? '${house.sign} IC'
                          : house.sign,
                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF231729,
                    ),
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            first
                ? 'La primera casa muestra cómo te presentas al mundo, tu forma de comenzar y la energía de tu ascendente.'
                : 'La cuarta casa habla de tus raíces, hogar, intimidad y la base emocional desde la que construyes seguridad.',
            style:
                const TextStyle(
              color:
                  Color(
                0xFF4F434F,
              ),
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}


// ================================================================
// PLANETS
// ================================================================

class _PlanetsSection
    extends StatelessWidget {
  final List<ChartPlanet> planets;
  final Color accentColor;
  final bool mobile;

  const _PlanetsSection({
    required this.planets,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width:
          double.infinity,
      padding:
          EdgeInsets.all(
        mobile ? 18 : 24,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title:
                'PLANETAS',
            accentColor:
                accentColor,
          ),

          const SizedBox(
            height: 18,
          ),

          if (planets.isEmpty)
            const Text(
              'No hay datos planetarios disponibles.',
            )
          else
            ...planets.map(
              (planet) =>
                  _PlanetRow(
                planet:
                    planet,
                accentColor:
                    accentColor,
                mobile:
                    mobile,
              ),
            ),
        ],
      ),
    );
  }
}


class _PlanetRow
    extends StatelessWidget {
  final ChartPlanet planet;
  final Color accentColor;
  final bool mobile;

  const _PlanetRow({
    required this.planet,
    required this.accentColor,
    required this.mobile,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    if (mobile) {
      return Container(
        padding:
            const EdgeInsets
                .symmetric(
          vertical: 12,
        ),
        decoration:
            _bottomLine(),
        child: Row(
          children: [
            SizedBox(
              width: 38,
              child: Text(
                _planetSymbol(
                  planet.planet,
                ),
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontSize: 22,
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    planet.planet,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  Text(
                    '${planet.sign} · ${planet.degree.toStringAsFixed(1)}° · ${planet.house == null ? 'Sin casa' : 'Casa ${planet.house}'}',
                    style:
                        const TextStyle(
                      color:
                          Color(
                        0xFF817380,
                      ),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            if (planet.retrograde)
              Text(
                'R',
                style:
                    TextStyle(
                  color:
                      accentColor,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
          ],
        ),
      );
    }

    return Container(
      padding:
          const EdgeInsets
              .symmetric(
        vertical: 12,
      ),
      decoration:
          _bottomLine(),
      child: Row(
        children: [
          SizedBox(
            width: 38,
            child: Text(
              _planetSymbol(
                planet.planet,
              ),
              style:
                  TextStyle(
                color:
                    accentColor,
                fontSize: 22,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              planet.planet,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              planet.sign,
            ),
          ),

          Expanded(
            child: Text(
              '${planet.degree.toStringAsFixed(1)}°',
            ),
          ),

          Expanded(
            child: Text(
              planet.house == null
                  ? '—'
                  : 'Casa ${planet.house}',
            ),
          ),

          SizedBox(
            width: 25,
            child:
                planet.retrograde
                    ? Text(
                        'R',
                        style:
                            TextStyle(
                          color:
                              accentColor,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      )
                    : null,
          ),
        ],
      ),
    );
  }
}


// ================================================================
// ALL HOUSES
// ================================================================

class _HousesGrid
    extends StatelessWidget {
  final List<ChartHouse> houses;
  final Color accentColor;
  final bool mobile;

  const _HousesGrid({
    required this.houses,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    if (houses.isEmpty) {
      return const _EmptySection(
        text:
            'No hay datos de casas disponibles.',
      );
    }

    return Container(
      width:
          double.infinity,
      padding:
          EdgeInsets.all(
        mobile ? 18 : 24,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title:
                'LAS CASAS',
            accentColor:
                accentColor,
          ),

          const SizedBox(
            height: 18,
          ),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount:
                houses.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  mobile ? 1 : 3,
              crossAxisSpacing:
                  14,
              mainAxisSpacing:
                  14,
              childAspectRatio:
                  mobile
                      ? 4.5
                      : 2.6,
            ),
            itemBuilder: (
              context,
              index,
            ) {
              final house =
                  houses[index];

              return Container(
                padding:
                    const EdgeInsets.all(
                  15,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFFFFBFE,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    9,
                  ),
                  border:
                      Border.all(
                    color:
                        const Color(
                      0xFFE8DFE7,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 46,
                      child: Text(
                        _roman(
                          house.number,
                        ),
                        style:
                            TextStyle(
                          color:
                              accentColor,
                          fontFamily:
                              'serif',
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            house.sign
                                .toUpperCase(),
                            style:
                                const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),

                          const SizedBox(
                            height: 3,
                          ),

                          Text(
                            '${house.degree.toStringAsFixed(2)}°',
                            style:
                                const TextStyle(
                              color:
                                  Color(
                                0xFF817380,
                              ),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// ================================================================
// ASPECTS
// ================================================================

class _AspectsSection
    extends StatelessWidget {
  final List<ChartAspect> aspects;
  final Color accentColor;
  final bool mobile;

  const _AspectsSection({
    required this.aspects,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width:
          double.infinity,
      padding:
          EdgeInsets.all(
        mobile ? 18 : 24,
      ),
      decoration:
          _cardDecoration(),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title:
                'ASPECTOS',
            accentColor:
                accentColor,
          ),

          const SizedBox(
            height: 18,
          ),

          if (aspects.isEmpty)
            const Text(
              'No hay aspectos disponibles.',
            )
          else
            ...aspects.map(
              (aspect) =>
                  Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 12,
                ),
                decoration:
                    _bottomLine(),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        _aspectSymbol(
                          aspect.type,
                        ),
                        style:
                            TextStyle(
                          color:
                              accentColor,
                          fontSize: 23,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${aspect.first} ${_aspectName(aspect.type)} ${aspect.second}',
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),

                          if (mobile) ...[
                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              'Orb ${aspect.orb.toStringAsFixed(2)}°',
                              style:
                                  const TextStyle(
                                color:
                                    Color(
                                  0xFF817380,
                                ),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    if (!mobile)
                      Text(
                        'Orb ${aspect.orb.toStringAsFixed(2)}°',
                        style:
                            const TextStyle(
                          color:
                              Color(
                            0xFF817380,
                          ),
                          fontSize: 11,
                        ),
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
// NATAL WHEEL PAINTER
// ================================================================

class _NatalWheelPainter
    extends CustomPainter {
  final List<ChartHouse> houses;
  final List<ChartPlanet> planets;
  final List<ChartAspect> aspects;
  final Color accentColor;

  _NatalWheelPainter({
    required this.houses,
    required this.planets,
    required this.aspects,
    required this.accentColor,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center =
        Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        size.shortestSide /
                2 -
            17;

    final mainPaint =
        Paint()
          ..color =
              accentColor
          ..style =
              PaintingStyle.stroke
          ..strokeWidth =
              1.15;

    final softPaint =
        Paint()
          ..color =
              accentColor
                  .withAlpha(
            70,
          )
          ..style =
              PaintingStyle.stroke
          ..strokeWidth =
              .75;

    final aspectPaint =
        Paint()
          ..color =
              accentColor
                  .withAlpha(
            95,
          )
          ..style =
              PaintingStyle.stroke
          ..strokeWidth =
              .75;

    canvas.drawCircle(
      center,
      radius,
      mainPaint,
    );

    canvas.drawCircle(
      center,
      radius * .84,
      softPaint,
    );

    canvas.drawCircle(
      center,
      radius * .66,
      softPaint,
    );

    canvas.drawCircle(
      center,
      radius * .47,
      softPaint,
    );

    // =========================================================
    // 12 SECTIONS
    // =========================================================

    for (int i = 0;
        i < 12;
        i++) {
      final angle =
          -math.pi / 2 +
              i *
                  2 *
                  math.pi /
                  12;

      final outer =
          Offset(
        center.dx +
            radius *
                math.cos(
                  angle,
                ),
        center.dy +
            radius *
                math.sin(
                  angle,
                ),
      );

      final inner =
          Offset(
        center.dx +
            radius *
                .47 *
                math.cos(
                  angle,
                ),
        center.dy +
            radius *
                .47 *
                math.sin(
                  angle,
                ),
      );

      canvas.drawLine(
        inner,
        outer,
        softPaint,
      );
    }

    // =========================================================
    // HOUSE NUMBERS
    // =========================================================

    for (int i = 0;
        i < 12;
        i++) {
      final angle =
          -math.pi / 2 +
              (i + .5) *
                  2 *
                  math.pi /
                  12;

      final point =
          Offset(
        center.dx +
            radius *
                .75 *
                math.cos(
                  angle,
                ),
        center.dy +
            radius *
                .75 *
                math.sin(
                  angle,
                ),
      );

      final text =
          TextPainter(
        text:
            TextSpan(
          text:
              '${i + 1}',
          style:
              TextStyle(
            color:
                accentColor
                    .withAlpha(
              175,
            ),
            fontSize: 9,
            fontWeight:
                FontWeight.w600,
          ),
        ),
        textDirection:
            TextDirection.ltr,
      );

      text.layout();

      text.paint(
        canvas,
        Offset(
          point.dx -
              text.width / 2,
          point.dy -
              text.height / 2,
        ),
      );
    }

    // =========================================================
    // PLANETS
    // =========================================================

    for (final planet
        in planets) {
      final absoluteDegree =
          _absoluteDegree(
        planet.sign,
        planet.degree,
      );

      final angle =
          -math.pi / 2 +
              absoluteDegree *
                  math.pi /
                  180;

      final point =
          Offset(
        center.dx +
            radius *
                .59 *
                math.cos(
                  angle,
                ),
        center.dy +
            radius *
                .59 *
                math.sin(
                  angle,
                ),
      );

      canvas.drawCircle(
        point,
        3.2,
        Paint()
          ..color =
              accentColor,
      );

      final symbolPoint =
          Offset(
        center.dx +
            radius *
                .92 *
                math.cos(
                  angle,
                ),
        center.dy +
            radius *
                .92 *
                math.sin(
                  angle,
                ),
      );

      final symbol =
          TextPainter(
        text:
            TextSpan(
          text:
              _planetSymbol(
            planet.planet,
          ),
          style:
              TextStyle(
            color:
                accentColor,
            fontSize: 14,
          ),
        ),
        textDirection:
            TextDirection.ltr,
      );

      symbol.layout();

      symbol.paint(
        canvas,
        Offset(
          symbolPoint.dx -
              symbol.width / 2,
          symbolPoint.dy -
              symbol.height / 2,
        ),
      );
    }

    // =========================================================
    // ASPECTS
    // =========================================================

    for (final aspect
        in aspects) {
      ChartPlanet? p1;
      ChartPlanet? p2;

      for (final planet
          in planets) {
        if (planet.planet
                .toLowerCase() ==
            aspect.first
                .toLowerCase()) {
          p1 = planet;
        }

        if (planet.planet
                .toLowerCase() ==
            aspect.second
                .toLowerCase()) {
          p2 = planet;
        }
      }

      if (p1 == null ||
          p2 == null) {
        continue;
      }

      final degree1 =
          _absoluteDegree(
        p1.sign,
        p1.degree,
      );

      final degree2 =
          _absoluteDegree(
        p2.sign,
        p2.degree,
      );

      final angle1 =
          -math.pi / 2 +
              degree1 *
                  math.pi /
                  180;

      final angle2 =
          -math.pi / 2 +
              degree2 *
                  math.pi /
                  180;

      final point1 =
          Offset(
        center.dx +
            radius *
                .43 *
                math.cos(
                  angle1,
                ),
        center.dy +
            radius *
                .43 *
                math.sin(
                  angle1,
                ),
      );

      final point2 =
          Offset(
        center.dx +
            radius *
                .43 *
                math.cos(
                  angle2,
                ),
        center.dy +
            radius *
                .43 *
                math.sin(
                  angle2,
                ),
      );

      canvas.drawLine(
        point1,
        point2,
        aspectPaint,
      );
    }
  }

  double _absoluteDegree(
    String sign,
    double degree,
  ) {
    const starts = {
      'aries': 0.0,
      'taurus': 30.0,
      'gemini': 60.0,
      'cancer': 90.0,
      'leo': 120.0,
      'virgo': 150.0,
      'libra': 180.0,
      'scorpio': 210.0,
      'sagittarius': 240.0,
      'capricorn': 270.0,
      'aquarius': 300.0,
      'pisces': 330.0,
    };

    return (
          starts[
                  sign
                      .toLowerCase()] ??
              0
        ) +
        degree;
  }

  @override
  bool shouldRepaint(
    covariant _NatalWheelPainter
        oldDelegate,
  ) {
    return oldDelegate
                .accentColor !=
            accentColor ||
        oldDelegate.planets !=
            planets ||
        oldDelegate.aspects !=
            aspects ||
        oldDelegate.houses !=
            houses;
  }
}


// ================================================================
// SHARED
// ================================================================

class _SectionTitle
    extends StatelessWidget {
  final String title;
  final Color accentColor;

  const _SectionTitle({
    required this.title,
    required this.accentColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      title,
      style:
          TextStyle(
        color:
            accentColor,
        fontSize: 11,
        letterSpacing: 2,
        fontWeight:
            FontWeight.w700,
      ),
    );
  }
}


class _EmptySection
    extends StatelessWidget {
  final String text;

  const _EmptySection({
    required this.text,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width:
          double.infinity,
      padding:
          const EdgeInsets.all(
        20,
      ),
      decoration:
          _cardDecoration(),
      child: Text(
        text,
      ),
    );
  }
}


// ================================================================
// DECORATION
// ================================================================

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
      14,
    ),
    border: Border.all(
      color: const Color(
        0xFFF0E7EF,
      ),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(
          10,
        ),
        blurRadius: 30,
        offset: const Offset(
          0,
          5,
        ),
      ),
    ],
  );
}


BoxDecoration _bottomLine() {
  return const BoxDecoration(
    border: Border(
      bottom:
          BorderSide(
        color:
            Color(
          0xFFE6DEE5,
        ),
      ),
    ),
  );
}


// ================================================================
// HELPERS
// ================================================================

ChartHouse? _findHouse(
  List<ChartHouse> houses,
  int number,
) {
  for (final house
      in houses) {
    if (house.number ==
        number) {
      return house;
    }
  }

  return null;
}


String _ordinal(
  int number,
) {
  switch (number) {
    case 1:
      return '1st';

    case 2:
      return '2nd';

    case 3:
      return '3rd';

    default:
      return '${number}th';
  }
}


String _roman(
  int number,
) {
  const values = {
    1: 'I',
    2: 'II',
    3: 'III',
    4: 'IV',
    5: 'V',
    6: 'VI',
    7: 'VII',
    8: 'VIII',
    9: 'IX',
    10: 'X',
    11: 'XI',
    12: 'XII',
  };

  return values[number] ??
      number.toString();
}


String _planetSymbol(
  String planet,
) {
  switch (
      planet.toLowerCase()) {
    case 'sun':
      return '☉';

    case 'moon':
      return '☾';

    case 'mercury':
      return '☿';

    case 'venus':
      return '♀';

    case 'mars':
      return '♂';

    case 'jupiter':
      return '♃';

    case 'saturn':
      return '♄';

    case 'uranus':
      return '♅';

    case 'neptune':
      return '♆';

    case 'pluto':
      return '♇';

    case 'node':
      return '☊';

    case 'chiron':
      return '⚷';

    case 'part of fortune':
      return '⊗';

    case 'lilith':
      return '⚸';

    default:
      return '•';
  }
}


String _aspectSymbol(
  String type,
) {
  switch (
      type.toLowerCase()) {
    case 'conjunction':
      return '☌';

    case 'opposition':
      return '☍';

    case 'square':
      return '□';

    case 'trine':
      return '△';

    case 'sextile':
      return '✶';

    default:
      return '·';
  }
}


String _aspectName(
  String type,
) {
  switch (
      type.toLowerCase()) {
    case 'conjunction':
      return 'conjunción';

    case 'opposition':
      return 'oposición';

    case 'square':
      return 'cuadratura';

    case 'trine':
      return 'trígono';

    case 'sextile':
      return 'sextil';

    default:
      return type;
  }
}