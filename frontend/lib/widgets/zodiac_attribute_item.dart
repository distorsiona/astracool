import 'package:flutter/material.dart';

class ZodiacAttributeItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  final Color accentColor;

  const ZodiacAttributeItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 42,
          height: 42,
          child: Center(
            child: icon,
          ),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: accentColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF202020),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}