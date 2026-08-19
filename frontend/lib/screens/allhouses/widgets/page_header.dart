import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final Color accentColor;
  final bool isMobile;
  final bool isTablet;

  const PageHeader({
    super.key,
    required this.accentColor,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR NATAL HOUSES',
          style: TextStyle(
            color: accentColor,
            fontSize: 11,
            letterSpacing: 2.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'The Twelve Houses',
          style: TextStyle(
            color: accentColor,
            fontFamily: 'serif',
            fontSize: isMobile ? 30 : (isTablet ? 35 : 40),
            height: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 760,
          ),
          child: const Text(
            'Each house represents a different area of your life. '
            'Its sign, ruling planet, planets inside it and aspects '
            'show how that area is expressed in your natal chart.',
            style: TextStyle(
              color: Color(0xFF6F626E),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
