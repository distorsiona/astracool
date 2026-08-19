import 'package:flutter/material.dart';

import '../../../theme/card_decorations.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final Widget child;

  const SectionCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: accentColor,
              fontSize: 10,
              height: 1.3,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}
