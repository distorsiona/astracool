import 'package:flutter/material.dart';

class ChartSectionTitle extends StatelessWidget {
  final String title;
  final Color accentColor;

  const ChartSectionTitle({
    super.key,
    required this.title,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: accentColor,
        fontSize: 11,
        height: 1.25,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
