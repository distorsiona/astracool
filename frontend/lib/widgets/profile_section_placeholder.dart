import 'package:flutter/material.dart';

class ProfileSectionPlaceholder extends StatelessWidget {
  final String title;
  final Color accentColor;
  final double height;

  const ProfileSectionPlaceholder({
    super.key,
    required this.title,
    required this.accentColor,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D0CA),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}