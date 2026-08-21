import 'package:flutter/material.dart';

import '../l10n/error_messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../l10n/locale_controller.dart';
import '../models/natal_chart_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';

import 'account_profile_screen.dart';
import 'allhouses_screen.dart';
import 'housedetail_screen.dart';
import 'profile_screen.dart';
import 'today_screen.dart';

import 'chart/chart_layout.dart';
import 'chart/widgets/aspects_section.dart';
import 'chart/widgets/big_three_panel.dart';
import 'chart/widgets/chart_wheel_card.dart';
import 'chart/widgets/featured_houses_section.dart';
import 'chart/widgets/planets_section.dart';
import 'chart/widgets/sign_details_panel.dart';

class ChartScreen extends StatefulWidget {
  final String userId;

  const ChartScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  NatalChartModel? natalChart;

  bool loading = true;
  Object? loadError;

  // se usan para volver a pedir la carta cuando el usuario
  // cambia de idioma en tiempo de ejecución (EN <-> ES).
  bool _initialized = false;
  String? _lastLanguage;

  @override
  void initState() {
    super.initState();
    // la carga inicial se dispara desde didChangeDependencies,
    // porque ahí sí es seguro leer LocaleScope.of(context).
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentLanguage = LocaleScope.of(context).value.languageCode;

    if (!_initialized) {
      _initialized = true;
      _lastLanguage = currentLanguage;
      _loadChart();
      return;
    }

    if (_lastLanguage != currentLanguage) {
      _lastLanguage = currentLanguage;
      _loadChart();
    }
  }

  // ============================================================
  // API
  // ============================================================

  Future<void> _loadChart() async {
    setState(() {
      loading = true;
      loadError = null;
    });

    try {
      final result = await ApiService.getChart(
        userId: widget.userId,
        language: LocaleScope.of(context).value.languageCode,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        natalChart = result;
        loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
        loadError = error;
      });
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _goToToday() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TodayScreen(
          userId: widget.userId,
        ),
      ),
    );
  }

  void _goToProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          userId: widget.userId,
        ),
      ),
    );
  }

  void _goToAccountProfile() {
    final data = natalChart;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountProfileScreen(
          userId: widget.userId,
          zodiacSign: data?.profile.sign,
        ),
      ),
    );
  }

  // ============================================================
  // ABRIR DETALLE DE UNA CASA
  // ============================================================

  void _openHouse(
    NatalChartModel data,
    int houseNumber,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HouseDetailScreen(
          userId: widget.userId,
          chartId: data.chart.id,
          houseNumber: houseNumber,
          zodiacSign: data.profile.sign,
        ),
      ),
    );
  }

  // ============================================================
  // ABRIR TODAS LAS CASAS
  //
  // AllHousesScreen obtiene directamente sus casas usando:
  //
  // GET /api/houses/{userId}
  //
  // por eso ya no recibe data.chart.houses.
  // ============================================================

  void _openAllHouses(
    NatalChartModel data,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AllHousesScreen(
          userId: widget.userId,
          chartId: data.chart.id,
          zodiacSign: data.profile.sign,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return _buildLoading();
    }

    if (loadError != null) {
      return _buildError();
    }

    final data = natalChart;

    if (data == null) {
      return _buildError(
        customMessage: AppLocalizations.of(context)!.chartLoadError,
      );
    }

    final accentColor = ZodiacTheme.colorForSign(
      data.profile.sign,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection: AstrologySection.chart,
              accentColor: accentColor,

              // today
              onToday: _goToToday,

              // ya estamos en chart
              onChart: () {},

              // week todavía pendiente
              onWeek: () {},

              // me
              onProfile: _goToProfile,

              // account settings
              onAccountProfile: _goToAccountProfile,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (
                  context,
                  constraints,
                ) {
                  final width = constraints.maxWidth;

                  final isMobile = width < 650;

                  final isTablet = width >= 650 && width < 1100;

                  final horizontalPadding = isMobile
                      ? 14.0
                      : isTablet
                          ? 28.0
                          : 46.0;

                  final verticalPadding = isMobile ? 18.0 : 28.0;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      verticalPadding,
                      horizontalPadding,
                      48,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
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
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(
    NatalChartModel data,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 66,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChartWheelCard(
                    data: data,
                    accentColor: accentColor,
                    layout: ChartLayout.desktop,
                  ),
                  const SizedBox(height: 24),
                  FeaturedHousesSection(
                    houses: data.chart.featuredHouses,
                    accentColor: accentColor,
                    layout: ChartLayout.desktop,
                    onViewAll: () => _openAllHouses(
                      data,
                    ),
                    onHouseTap: (houseNumber) => _openHouse(
                      data,
                      houseNumber,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 34,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BigThreePanel(
                    bigThree: data.chart.bigThree,
                    accentColor: accentColor,
                    layout: ChartLayout.desktop,
                  ),
                  const SizedBox(height: 20),
                  SignDetailsPanel(
                    profile: data.profile,
                    accentColor: accentColor,
                    layout: ChartLayout.desktop,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        PlanetsSection(
          planets: data.chart.planets,
          accentColor: accentColor,
          layout: ChartLayout.desktop,
        ),
        const SizedBox(height: 24),
        AspectsSection(
          aspects: data.chart.aspects,
          accentColor: accentColor,
          layout: ChartLayout.desktop,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ChartWheelCard(
          data: data,
          accentColor: accentColor,
          layout: ChartLayout.tablet,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BigThreePanel(
                bigThree: data.chart.bigThree,
                accentColor: accentColor,
                layout: ChartLayout.tablet,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: SignDetailsPanel(
                profile: data.profile,
                accentColor: accentColor,
                layout: ChartLayout.tablet,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        FeaturedHousesSection(
          houses: data.chart.featuredHouses,
          accentColor: accentColor,
          layout: ChartLayout.tablet,
          onViewAll: () => _openAllHouses(
            data,
          ),
          onHouseTap: (houseNumber) => _openHouse(
            data,
            houseNumber,
          ),
        ),
        const SizedBox(height: 24),
        PlanetsSection(
          planets: data.chart.planets,
          accentColor: accentColor,
          layout: ChartLayout.tablet,
        ),
        const SizedBox(height: 24),
        AspectsSection(
          aspects: data.chart.aspects,
          accentColor: accentColor,
          layout: ChartLayout.tablet,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ChartWheelCard(
          data: data,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
        ),
        const SizedBox(height: 16),
        BigThreePanel(
          bigThree: data.chart.bigThree,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
        ),
        const SizedBox(height: 16),
        SignDetailsPanel(
          profile: data.profile,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
        ),
        const SizedBox(height: 20),
        FeaturedHousesSection(
          houses: data.chart.featuredHouses,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
          onViewAll: () => _openAllHouses(
            data,
          ),
          onHouseTap: (houseNumber) => _openHouse(
            data,
            houseNumber,
          ),
        ),
        const SizedBox(height: 20),
        PlanetsSection(
          planets: data.chart.planets,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
        ),
        const SizedBox(height: 20),
        AspectsSection(
          aspects: data.chart.aspects,
          accentColor: accentColor,
          layout: ChartLayout.mobile,
        ),
      ],
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading() {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F1EE),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError({
    String? customMessage,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                customMessage ??
                    (loadError != null
                        ? describeError(
                            context,
                            loadError!,
                          )
                        : l10n.chartLoadError),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _loadChart,
                child: Text(
                  l10n.retry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
