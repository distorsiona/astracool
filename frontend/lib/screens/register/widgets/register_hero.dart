import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/auth_colors.dart';

class RegisterHero extends StatelessWidget {
  final bool mobile;

  const RegisterHero({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      height: mobile ? 190 : double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_astral.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE9DAEA),
                      Color(0xFFF7EEF6),
                      Color(0xFFE2D5E4),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.blur_circular,
                    color: authPurple.withAlpha(80),
                    size: mobile ? 110 : 230,
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(8),
                  const Color(0xFFFBEAF7).withAlpha(mobile ? 110 : 185),
                ],
              ),
            ),
          ),
          Positioned(
            left: mobile ? 22 : 42,
            right: mobile ? 22 : 42,
            bottom: mobile ? 20 : 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.stars_outlined,
                  color: authDarkPurple,
                  size: mobile ? 20 : 24,
                ),
                SizedBox(height: mobile ? 6 : 12),
                Text(
                  l10n.registerHeroTitle,
                  style: TextStyle(
                    color: authDarkPurple,
                    fontFamily: 'serif',
                    fontSize: mobile ? 22 : 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!mobile) ...[
                  const SizedBox(height: 10),
                  Text(
                    l10n.registerHeroSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF554B55),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
