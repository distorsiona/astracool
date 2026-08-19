import 'package:flutter/material.dart';

import '../models/today_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';

import 'chart_screen.dart';
import 'profile_screen.dart';

import 'today/widgets/affected_houses_card.dart';
import 'today/widgets/big_three_today.dart';
import 'today/widgets/bottom_summary.dart';
import 'today/widgets/themes_card.dart';
import 'today/widgets/today_hero.dart';
import 'today/widgets/transits_card.dart';

class TodayScreen extends StatefulWidget {
  final String userId;

  const TodayScreen({super.key, required this.userId});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  TodayModel? data;

  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiService.getToday(userId: widget.userId);

      if (!mounted) return;

      setState(() {
        data = result;
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

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F2EF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null || data == null) {
      return _error();
    }

    final today = data!;

    final accentColor = ZodiacTheme.colorForSign(today.bigThree.sun);

    final width = MediaQuery.sizeOf(context).width;

    final mobile = width < 700;

    final tablet = width >= 700 && width < 1050;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2EF),
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection: AstrologySection.today,
              accentColor: accentColor,
              onToday: () {},
              onChart: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChartScreen(userId: widget.userId),
                  ),
                );
              },
              onWeek: () {},
              onProfile: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(userId: widget.userId),
                  ),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  mobile
                      ? 14
                      : tablet
                          ? 24
                          : 40,
                  mobile ? 18 : 28,
                  mobile
                      ? 14
                      : tablet
                          ? 24
                          : 40,
                  40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: mobile
                        ? _mobile(today, accentColor)
                        : tablet
                            ? _tablet(today, accentColor)
                            : _desktop(today, accentColor),
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

  Widget _desktop(TodayModel today, Color accentColor) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 44,
              child: TodayHero(data: today, accentColor: accentColor),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 56,
              child: Column(
                children: [
                  BigThreeToday(
                    data: today.bigThree,
                    accentColor: accentColor,
                  ),
                  const SizedBox(height: 18),
                  TransitsCard(
                    transits: today.transits,
                    accentColor: accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AffectedHousesCard(
                houses: today.affectedHouses,
                accentColor: accentColor,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: ThemesCard(themes: today.themes, accentColor: accentColor),
            ),
          ],
        ),
        const SizedBox(height: 18),
        BottomSummary(
          focus: today.focus,
          luckyTime: today.luckyTime,
          luckyColor: today.luckyColor,
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _tablet(TodayModel today, Color accentColor) {
    return Column(
      children: [
        TodayHero(data: today, accentColor: accentColor),
        const SizedBox(height: 18),
        BigThreeToday(data: today.bigThree, accentColor: accentColor),
        const SizedBox(height: 18),
        TransitsCard(transits: today.transits, accentColor: accentColor),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AffectedHousesCard(
                houses: today.affectedHouses,
                accentColor: accentColor,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: ThemesCard(themes: today.themes, accentColor: accentColor),
            ),
          ],
        ),
        const SizedBox(height: 18),
        BottomSummary(
          focus: today.focus,
          luckyTime: today.luckyTime,
          luckyColor: today.luckyColor,
          accentColor: accentColor,
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _mobile(TodayModel today, Color accentColor) {
    return Column(
      children: [
        TodayHero(data: today, accentColor: accentColor, mobile: true),
        const SizedBox(height: 14),
        BigThreeToday(data: today.bigThree, accentColor: accentColor),
        const SizedBox(height: 14),
        TransitsCard(
          transits: today.transits,
          accentColor: accentColor,
          mobile: true,
        ),
        const SizedBox(height: 14),
        AffectedHousesCard(
          houses: today.affectedHouses,
          accentColor: accentColor,
        ),
        const SizedBox(height: 14),
        ThemesCard(themes: today.themes, accentColor: accentColor),
        const SizedBox(height: 14),
        BottomSummary(
          focus: today.focus,
          luckyTime: today.luckyTime,
          luckyColor: today.luckyColor,
          accentColor: accentColor,
          mobile: true,
        ),
      ],
    );
  }

  Widget _error() {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2EF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome_outlined, size: 48),
              const SizedBox(height: 15),
              Text(
                errorMessage ?? 'No fue posible cargar TODAY.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(onPressed: _load, child: const Text('Reintentar')),
            ],
          ),
        ),
      ),
    );
  }
}
