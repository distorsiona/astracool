import 'package:flutter/material.dart';

import '../../../theme/auth_colors.dart';

class LoginHero extends StatelessWidget {
  final bool mobile;

  const LoginHero({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: mobile ? 190 : double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // IMAGEN
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
          // CAPA ROSADA
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(15),
                  const Color(0xFFFBEAF7).withAlpha(mobile ? 100 : 180),
                ],
              ),
            ),
          ),
          // TEXTO HERO
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
                  size: mobile ? 20 : 25,
                ),
                SizedBox(height: mobile ? 5 : 12),
                Text(
                  'Tu destino te espera.',
                  style: TextStyle(
                    color: authDarkPurple,
                    fontFamily: 'serif',
                    fontSize: mobile ? 22 : 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!mobile) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'Conecta con tu esencia cósmica y '
                    'descubre lo que los astros tienen preparado para ti.',
                    style: TextStyle(
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
