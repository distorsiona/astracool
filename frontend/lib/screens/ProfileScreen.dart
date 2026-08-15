import 'package:flutter/material.dart';

import '../models/zodiac_profile_model.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/astrology_top_navigation.dart';
import '../widgets/big_three_card.dart';
import '../widgets/profile_section_placeholder.dart';
import '../widgets/zodiac_profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ZodiacProfileModel get _mockProfile {
    return const ZodiacProfileModel(
      sign: 'Scorpio',
      dateRange: '23 oct - 21 nov',
      element: ZodiacElement.water,
      modality: ZodiacModality.fixed,
      rulingPlanet: 'Pluto',
      symbol: '♏',
      sun: BigThreeItem(
        label: 'Sun',
        sign: 'Scorpio',
        degree: '18° 24′',
        symbol: '☉',
      ),
      moon: BigThreeItem(
        label: 'Moon',
        sign: 'Pisces',
        degree: '07° 13′',
        symbol: '☾',
      ),
      rising: BigThreeItem(
        label: 'Rising',
        sign: 'Leo',
        degree: '12° 42′',
        symbol: '↑',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = _mockProfile;

    final accentColor =
        ZodiacTheme.colorForSign(profile.sign);

    return Scaffold(
      backgroundColor: ZodiacTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool desktop =
                constraints.maxWidth >= 1000;

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1500,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: desktop ? 44 : 18,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        AstrologyTopNavigation(
                          activeSection:
                              AstrologySection.profile,
                          accentColor: accentColor,
                          onToday: () {},
                          onChart: () {},
                          onWeek: () {},
                          onProfile: () {},
                        ),

                        const SizedBox(height: 36),

                        if (desktop)
                          _desktopLayout(
                            profile,
                            accentColor,
                          )
                        else
                          _mobileLayout(
                            profile,
                            accentColor,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _desktopLayout(
    ZodiacProfileModel profile,
    Color accentColor,
  ) {
    return Column(
      children: [
        ZodiacProfileHeader(
          profile: profile,
          accentColor: accentColor,
        ),

        const SizedBox(height: 24),

        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: ProfileSectionPlaceholder(
                title: 'Today',
                accentColor: accentColor,
                height: 280,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 4,
              child: ProfileSectionPlaceholder(
                title: 'Active Transits',
                accentColor: accentColor,
                height: 280,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 3,
              child: ProfileSectionPlaceholder(
                title: 'This Week',
                accentColor: accentColor,
                height: 280,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        ProfileSectionPlaceholder(
          title: 'Your Chart',
          accentColor: accentColor,
          height: 180,
        ),
      ],
    );
  }

  Widget _mobileLayout(
    ZodiacProfileModel profile,
    Color accentColor,
  ) {
    return Column(
      children: [
        ZodiacProfileHeader(
          profile: profile,
          accentColor: accentColor,
        ),

        const SizedBox(height: 22),

        BigThreeCard(
          sun: profile.sun,
          moon: profile.moon,
          rising: profile.rising,
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        ProfileSectionPlaceholder(
          title: 'Today',
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        ProfileSectionPlaceholder(
          title: 'Active Transits',
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        ProfileSectionPlaceholder(
          title: 'This Week',
          accentColor: accentColor,
        ),

        const SizedBox(height: 18),

        ProfileSectionPlaceholder(
          title: 'Your Chart',
          accentColor: accentColor,
        ),
      ],
    );
  }
}