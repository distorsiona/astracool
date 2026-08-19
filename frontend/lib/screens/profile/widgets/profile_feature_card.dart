import 'package:flutter/material.dart';

import '../helpers/profile_card_decoration.dart';

enum FeatureType { today, transits, week }

class ProfileFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;

  final IconData icon;
  final Color accentColor;
  final FeatureType type;

  final VoidCallback? onTap;

  final bool mobile;
  final double minHeight;

  const ProfileFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    required this.icon,
    required this.accentColor,
    required this.type,
    this.onTap,
    this.mobile = false,
    this.minHeight = 210,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: mobile ? 165 : minHeight),
          padding: EdgeInsets.all(mobile ? 18 : 28),
          decoration: profileCardDecoration(),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -30,
                child: IgnorePointer(
                  child: FeatureCardGlyph(
                    type: type,
                    color: accentColor.withAlpha(45),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: accentColor, size: mobile ? 37 : 52),
                  SizedBox(width: mobile ? 14 : 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: accentColor,
                            fontSize: mobile ? 13 : 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: mobile ? 260 : 250,
                          ),
                          child: Text(
                            description,
                            style: TextStyle(
                              color: const Color(0xFF252525),
                              fontSize: mobile ? 13 : 15,
                              height: 1.55,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              actionText,
                              style: TextStyle(
                                color: accentColor,
                                fontSize: mobile ? 12 : 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: accentColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCardGlyph extends StatelessWidget {
  final FeatureType type;
  final Color color;

  const FeatureCardGlyph({
    super.key,
    required this.type,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case FeatureType.today:
        return Icon(Icons.blur_circular, size: 170, color: color);

      case FeatureType.transits:
        return Transform.rotate(
          angle: .5,
          child: Icon(Icons.all_inclusive, size: 170, color: color),
        );

      case FeatureType.week:
        return Icon(Icons.auto_awesome, size: 155, color: color);
    }
  }
}
