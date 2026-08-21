import 'package:flutter/material.dart';

import '../l10n/error_messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/zodiac_profile_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';
import '../widgets/big_three_card.dart';
import '../widgets/zodiac_profile_header.dart';

import 'chart_screen.dart';
import 'today_screen.dart';
import 'account_profile_screen.dart';

import 'profile/widgets/profile_feature_card.dart';
import 'profile/widgets/your_chart_card.dart';



class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ZodiacProfileModel? profile;

  bool loading = true;
  Object? loadError;

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
      loadError = null;
    });

    try {
      final result = await ApiService.getProfile(userId: widget.userId);

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
        builder: (_) => TodayScreen(userId: widget.userId),
      ),
    );
  }

  void _goToChart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChartScreen(userId: widget.userId),
      ),
    );
  }

  void _goToAccountProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountProfileScreen(
          userId: widget.userId,
          zodiacSign: profile!.sign,
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

    if (profile == null) {
      return _buildError(
        customMessage: AppLocalizations.of(context)!.profileLoadError,
      );
    }

    final currentProfile = profile!;

    final accentColor = ZodiacTheme.colorForSign(currentProfile.sign);

    return Scaffold(
      backgroundColor: ZodiacTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            AstrologyTopNavigation(
              activeSection: AstrologySection.profile,
              accentColor: accentColor,
              onToday: _goToToday,
              onChart: _goToChart,
              onWeek: () {},
              onProfile: () {},
              onAccountProfile: _goToAccountProfile,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;

                    final isMobile = width < 650;

                    final isTablet = width >= 650 && width < 1100;

                    final horizontalPadding = isMobile
                        ? 14.0
                        : isTablet
                            ? 28.0
                            : 46.0;

                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isMobile ? 18 : 36,
                        horizontalPadding,
                        40,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1540),
                          child: isMobile
                              ? _buildMobile(currentProfile, accentColor)
                              : isTablet
                                  ? _buildTablet(currentProfile, accentColor)
                                  : _buildDesktop(currentProfile, accentColor),
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

  Widget _buildDesktop(ZodiacProfileModel profile, Color accentColor) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // PROFILE HEADER + BIG THREE
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        // FEATURE CARDS
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProfileFeatureCard(
                title: l10n.featureTodayTitle,
                description: l10n.featureTodayDescription,
                actionText: l10n.featureTodayAction,
                icon: Icons.wb_sunny_outlined,
                accentColor: accentColor,
                type: FeatureType.today,
                onTap: _goToToday,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: ProfileFeatureCard(
                title: l10n.featureTransitsTitle,
                description: l10n.featureTransitsDescription,
                actionText: l10n.featureTransitsAction,
                icon: Icons.public_outlined,
                accentColor: accentColor,
                type: FeatureType.transits,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: ProfileFeatureCard(
                title: l10n.featureWeekTitle,
                description: l10n.featureWeekDescription,
                actionText: l10n.featureWeekAction,
                icon: Icons.calendar_month_outlined,
                accentColor: accentColor,
                type: FeatureType.week,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // CHART
        YourChartCard(accentColor: accentColor, onTap: _goToChart),
      ],
    );
  }

  // ============================================================
  // TABLET
  // ============================================================

  Widget _buildTablet(ZodiacProfileModel profile, Color accentColor) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        ZodiacProfileHeader(profile: profile, accentColor: accentColor),
        const SizedBox(height: 20),
        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProfileFeatureCard(
                title: l10n.featureTodayTitle,
                description: l10n.featureTodayDescription,
                actionText: l10n.featureTodayAction,
                icon: Icons.wb_sunny_outlined,
                accentColor: accentColor,
                type: FeatureType.today,
                onTap: _goToToday,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfileFeatureCard(
                title: l10n.featureTransitsTitle,
                description: l10n.featureTransitsDescription,
                actionText: l10n.featureTransitsAction,
                icon: Icons.public_outlined,
                accentColor: accentColor,
                type: FeatureType.transits,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // WEEK
        ProfileFeatureCard(
          title: l10n.featureWeekTitle,
          description: l10n.featureWeekDescription,
          actionText: l10n.featureWeekAction,
          icon: Icons.calendar_month_outlined,
          accentColor: accentColor,
          type: FeatureType.week,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        // CHART
        YourChartCard(accentColor: accentColor, onTap: _goToChart),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(ZodiacProfileModel profile, Color accentColor) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        ZodiacProfileHeader(profile: profile, accentColor: accentColor),
        const SizedBox(height: 16),
        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),
        const SizedBox(height: 16),
        // TODAY
        ProfileFeatureCard(
          title: l10n.featureTodayTitle,
          description: l10n.featureTodayDescription,
          actionText: l10n.featureTodayAction,
          icon: Icons.wb_sunny_outlined,
          accentColor: accentColor,
          type: FeatureType.today,
          mobile: true,
          onTap: _goToToday,
        ),
        const SizedBox(height: 14),
        // TRANSITS
        ProfileFeatureCard(
          title: l10n.featureTransitsTitle,
          description: l10n.featureTransitsDescription,
          actionText: l10n.featureTransitsAction,
          icon: Icons.public_outlined,
          accentColor: accentColor,
          type: FeatureType.transits,
          mobile: true,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        // WEEK
        ProfileFeatureCard(
          title: l10n.featureWeekTitle,
          description: l10n.featureWeekDescription,
          actionText: l10n.featureWeekAction,
          icon: Icons.calendar_month_outlined,
          accentColor: accentColor,
          type: FeatureType.week,
          mobile: true,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        // CHART
        YourChartCard(
            accentColor: accentColor, mobile: true, onTap: _goToChart),
      ],
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading() {
    return Scaffold(
      backgroundColor: ZodiacTheme.background,
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError({String? customMessage}) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ZodiacTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 46),
              const SizedBox(height: 16),
              Text(
                customMessage ??
                    (loadError != null
                        ? describeError(context, loadError!)
                        : l10n.profileLoadError),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _loadProfile,
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
