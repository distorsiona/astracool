import 'package:flutter/material.dart';

class TodayTitleLine extends StatelessWidget {
  final String title;
  final Color accentColor;

  const TodayTitleLine({
    super.key,
    required this.title,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: accentColor.withAlpha(50))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            title,
            style: TextStyle(
              color: accentColor,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Divider(color: accentColor.withAlpha(50))),
      ],
    );
  }
}
