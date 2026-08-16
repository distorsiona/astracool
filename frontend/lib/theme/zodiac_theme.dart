import 'package:flutter/material.dart';

class ZodiacTheme {
  static const String fontSignName = 'Gothica2';

  static const Color background = Color(0xFFE5E5DF);

  static const Color textPrimary = Color(0xFF202020);

  static const Color textSecondary = Color(0xFF777777);

  static const Color cardBorder = Color(0xFFD0D0CA);

  static const Map<String, Color> signColors = {
    'aries': Color(0xFFC34848),
    'taurus': Color(0xFF678D63),
    'gemini': Color(0xFFD4A83D),
    'cancer': Color(0xFF7896B5),
    'leo': Color(0xFFD88C35),
    'virgo': Color(0xFF8B9270),
    'libra': Color(0xFFB67C98),
    'scorpio': Color(0xFF8A318E),
    'sagittarius': Color(0xFFB24C69),
    'capricorn': Color(0xFF63615A),
    'aquarius': Color(0xFF5993A6),
    'pisces': Color(0xFF617FB0),
  };

  static Color colorForSign(String sign) {
    return signColors[sign.toLowerCase()] ??  
        const Color(0xFF8A318E);
  }
}