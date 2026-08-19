import 'package:flutter/material.dart';

import '../models/house_detail_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/sacred_detail_top_bar.dart';

import 'housedetail/house_layout.dart';
import 'housedetail/widgets/house_hero_card.dart';
import 'housedetail/widgets/house_meaning_section.dart';
import 'housedetail/widgets/house_ruler_section.dart';
import 'housedetail/widgets/planets_in_house_section.dart';

class HouseDetailScreen extends StatefulWidget {
  final String userId;

  // Lo mantenemos temporalmente para no romper las navegaciones
  // existentes desde ChartScreen y AllHousesScreen.
  final String chartId;

  final int houseNumber;
  final String zodiacSign;

  const HouseDetailScreen({
    super.key,
    required this.userId,
    required this.chartId,
    required this.houseNumber,
    required this.zodiacSign,
  });

  @override
  State<HouseDetailScreen> createState() =>
      _HouseDetailScreenState();
}

class _HouseDetailScreenState
    extends State<HouseDetailScreen> {
  final ApiService _apiService = ApiService();

  HouseDetailModel? _data;

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHouse();
  }

  // ============================================================
  // CARGAR DETALLE PERSONALIZADO
  //
  // GET /api/houses/{userId}/{houseNumber}
  // ============================================================

  Future<void> _loadHouse() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _apiService.getHouseDetail(
        widget.userId,
        widget.houseNumber,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _data = result;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = error.toString();
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final accentColor = ZodiacTheme.colorForSign(
      widget.zodiacSign,
    );

    if (_isLoading) {
      return _buildLoading(accentColor);
    }

    if (_errorMessage != null) {
      return _buildError(accentColor);
    }

    final data = _data;

    if (data == null) {
      return _buildError(
        accentColor,
        customMessage:
            'No fue posible cargar esta casa.',
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            SacredDetailTopBar(
              accentColor: accentColor,
              trailingLabel:
                  'HOUSE ${data.house.roman}',
              onBack: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
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

                  final topPadding =
                      isMobile
                          ? 18.0
                          : 28.0;

                  return RefreshIndicator(
                    onRefresh: _loadHouse,
                    child: SingleChildScrollView(
                      physics:
                          const AlwaysScrollableScrollPhysics(
                        parent:
                            BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        topPadding,
                        horizontalPadding,
                        48,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(
                            maxWidth: 1540,
                          ),
                          child: isMobile
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(
    HouseDetailModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        HouseHeroCard(
          house: data.house,
          accentColor: accentColor,
          layout: HouseLayout.mobile,
        ),

        const SizedBox(height: 18),

        _PersonalInterpretationCard(
          data: data,
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        HouseMeaningSection(
          house: data.house,
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        HouseRulerSection(
          house: data.house,
          rulerPlacement:
              data.rulerPlacement,
          accentColor: accentColor,
          compact: true,
        ),

        const SizedBox(height: 18),

        PlanetsInHouseSection(
          house: data.house,
          accentColor: accentColor,
        ),

        if (data.interpretation
            .planetInfluences.isNotEmpty) ...[
          const SizedBox(height: 18),

          _PlanetaryInfluencesCard(
            influences: data.interpretation
                .planetInfluences,
            accentColor: accentColor,
          ),
        ],

        if (data.interpretation
            .howThisMayShowUp.isNotEmpty) ...[
          const SizedBox(height: 18),

          _HowThisMayShowUpCard(
            items: data.interpretation
                .howThisMayShowUp,
            accentColor: accentColor,
          ),
        ],
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet(
    HouseDetailModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        HouseHeroCard(
          house: data.house,
          accentColor: accentColor,
          layout: HouseLayout.tablet,
        ),

        const SizedBox(height: 20),

        _PersonalInterpretationCard(
          data: data,
          accentColor: accentColor,
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: HouseMeaningSection(
                house: data.house,
                accentColor:
                    accentColor,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: HouseRulerSection(
                house: data.house,
                rulerPlacement:
                    data.rulerPlacement,
                accentColor:
                    accentColor,
                compact: false,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        PlanetsInHouseSection(
          house: data.house,
          accentColor: accentColor,
        ),

        if (data.interpretation
            .planetInfluences.isNotEmpty) ...[
          const SizedBox(height: 20),

          _PlanetaryInfluencesCard(
            influences: data.interpretation
                .planetInfluences,
            accentColor: accentColor,
          ),
        ],

        if (data.interpretation
            .howThisMayShowUp.isNotEmpty) ...[
          const SizedBox(height: 20),

          _HowThisMayShowUpCard(
            items: data.interpretation
                .howThisMayShowUp,
            accentColor: accentColor,
          ),
        ],
      ],
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(
    HouseDetailModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        // --------------------------------------------------------
        // HERO + INFORMACIÓN TÉCNICA
        // --------------------------------------------------------

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 58,
              child: HouseHeroCard(
                house: data.house,
                accentColor:
                    accentColor,
                layout:
                    HouseLayout.desktop,
              ),
            ),

            const SizedBox(width: 22),

            Expanded(
              flex: 42,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  HouseRulerSection(
                    house: data.house,
                    rulerPlacement:
                        data.rulerPlacement,
                    accentColor:
                        accentColor,
                    compact: false,
                  ),

                  const SizedBox(height: 18),

                  PlanetsInHouseSection(
                    house: data.house,
                    accentColor:
                        accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // --------------------------------------------------------
        // INTERPRETACIÓN PRINCIPAL
        // --------------------------------------------------------

        _PersonalInterpretationCard(
          data: data,
          accentColor: accentColor,
        ),

        const SizedBox(height: 24),

        // --------------------------------------------------------
        // SIGNO + REGENTE
        // --------------------------------------------------------

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InterpretationDetailCard(
                eyebrow:
                    data.interpretation.signTitle,
                text: data.interpretation
                    .signInterpretation,
                accentColor:
                    accentColor,
              ),
            ),

            const SizedBox(width: 22),

            Expanded(
              child: _InterpretationDetailCard(
                eyebrow:
                    data.interpretation.rulerTitle,
                text: data.interpretation
                    .rulerInterpretation,
                accentColor:
                    accentColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // --------------------------------------------------------
        // SIGNIFICADO GENERAL
        // --------------------------------------------------------

        HouseMeaningSection(
          house: data.house,
          accentColor: accentColor,
        ),

        if (data.interpretation
            .planetInfluences.isNotEmpty) ...[
          const SizedBox(height: 24),

          _PlanetaryInfluencesCard(
            influences: data.interpretation
                .planetInfluences,
            accentColor: accentColor,
          ),
        ],

        if (data.interpretation
            .howThisMayShowUp.isNotEmpty) ...[
          const SizedBox(height: 24),

          _HowThisMayShowUpCard(
            items: data.interpretation
                .howThisMayShowUp,
            accentColor: accentColor,
          ),
        ],
      ],
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading(
    Color accentColor,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: Center(
        child: CircularProgressIndicator(
          color: accentColor,
        ),
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError(
    Color accentColor, {
    String? customMessage,
  }) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F1EE),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_outlined,
                color: accentColor,
                size: 44,
              ),

              const SizedBox(height: 16),

              Text(
                customMessage ??
                    _errorMessage ??
                    'No fue posible cargar esta casa.',
                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(height: 18),

              FilledButton(
                onPressed: _loadHouse,
                style:
                    FilledButton.styleFrom(
                  backgroundColor:
                      accentColor,
                ),
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

// ============================================================
// WHAT THIS MEANS FOR YOU
// ============================================================

class _PersonalInterpretationCard
    extends StatelessWidget {
  final HouseDetailModel data;
  final Color accentColor;

  const _PersonalInterpretationCard({
    required this.data,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final interpretation =
        data.interpretation;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: _cardDecoration(
        accentColor,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'WHAT THIS MEANS FOR YOU',
            style: TextStyle(
              color: accentColor,
              fontSize: 12,
              letterSpacing: 2.2,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            interpretation.summary,
            style: const TextStyle(
              color: Color(0xFF332735),
              fontSize: 15,
              height: 1.75,
              fontWeight:
                  FontWeight.w400,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            width: 44,
            height: 2,
            color: accentColor.withValues(
              alpha: 0.65,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            interpretation.signTitle
                .toUpperCase(),
            style: TextStyle(
              color: accentColor,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            interpretation
                .signInterpretation,
            style: const TextStyle(
              color: Color(0xFF625762),
              fontSize: 13,
              height: 1.65,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            interpretation.rulerTitle
                .toUpperCase(),
            style: TextStyle(
              color: accentColor,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            interpretation
                .rulerInterpretation,
            style: const TextStyle(
              color: Color(0xFF625762),
              fontSize: 13,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INTERPRETATION DETAIL
// ============================================================

class _InterpretationDetailCard
    extends StatelessWidget {
  final String eyebrow;
  final String text;
  final Color accentColor;

  const _InterpretationDetailCard({
    required this.eyebrow,
    required this.text,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(
        accentColor,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: TextStyle(
              color: accentColor,
              fontSize: 11,
              letterSpacing: 1.6,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF625762),
              fontSize: 13,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PLANETARY INFLUENCES
// ============================================================

class _PlanetaryInfluencesCard
    extends StatelessWidget {
  final List<PlanetInfluenceModel>
      influences;

  final Color accentColor;

  const _PlanetaryInfluencesCard({
    required this.influences,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: _cardDecoration(
        accentColor,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'PLANETARY INFLUENCES',
            style: TextStyle(
              color: accentColor,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 22),

          ...List.generate(
            influences.length,
            (index) {
              final influence =
                  influences[index];

              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 38,
                        child: Text(
                          influence.symbol,
                          style: TextStyle(
                            color:
                                accentColor,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              influence.title
                                  .toUpperCase(),
                              style: const TextStyle(
                                color:
                                    Color(0xFF2D2130),
                                fontSize: 13,
                                letterSpacing:
                                    .8,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              influence
                                  .interpretation,
                              style:
                                  const TextStyle(
                                color:
                                    Color(0xFF6D626C),
                                fontSize: 12.5,
                                height: 1.65,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (index <
                      influences.length -
                          1) ...[
                    const SizedBox(
                      height: 20,
                    ),

                    Divider(
                      height: 1,
                      color: accentColor
                          .withValues(
                        alpha: 0.12,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOW THIS MAY SHOW UP
// ============================================================

class _HowThisMayShowUpCard
    extends StatelessWidget {
  final List<String> items;
  final Color accentColor;

  const _HowThisMayShowUpCard({
    required this.items,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: _cardDecoration(
        accentColor,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'HOW THIS MAY SHOW UP',
            style: TextStyle(
              color: accentColor,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          ...items.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 13,
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin:
                        const EdgeInsets.only(
                      top: 7,
                    ),
                    decoration:
                        BoxDecoration(
                      color: accentColor,
                      shape:
                          BoxShape.circle,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Text(
                      item,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF625762),
                        fontSize: 13,
                        height: 1.55,
                      ),
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

// ============================================================
// DECORACIÓN LOCAL
// ============================================================

BoxDecoration _cardDecoration(
  Color accentColor,
) {
  return BoxDecoration(
    color: Colors.white.withValues(
      alpha: 0.86,
    ),
    borderRadius:
        BorderRadius.circular(20),
    border: Border.all(
      color: accentColor.withValues(
        alpha: 0.10,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.025,
        ),
        blurRadius: 22,
        offset: const Offset(0, 8),
      ),
    ],
  );
}