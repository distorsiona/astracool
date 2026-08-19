import 'package:flutter/material.dart';

import '../../../models/natal_chart_model.dart';
import '../../../utils/astrology_symbols.dart';
import '../../../theme/card_decorations.dart';
import '../chart_layout.dart';
import 'chart_section_title.dart';

class AspectsSection extends StatelessWidget {
  final List<ChartAspect> aspects;
  final Color accentColor;
  final ChartLayout layout;

  const AspectsSection({
    super.key,
    required this.aspects,
    required this.accentColor,
    required this.layout,
  });

  bool get compact => layout != ChartLayout.desktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout == ChartLayout.mobile ? 18 : 24),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChartSectionTitle(title: 'ASPECTS', accentColor: accentColor),
          const SizedBox(height: 18),
          if (aspects.isEmpty)
            const Text('No hay aspectos disponibles.')
          else
            ...aspects.map(
              (aspect) => AspectRow(
                aspect: aspect,
                accentColor: accentColor,
                compact: compact,
              ),
            ),
        ],
      ),
    );
  }
}

class AspectRow extends StatelessWidget {
  final ChartAspect aspect;
  final Color accentColor;
  final bool compact;

  const AspectRow({
    super.key,
    required this.aspect,
    required this.accentColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: bottomLineDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              aspectSymbol(aspect.type),
              style: TextStyle(color: accentColor, fontSize: 23),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${aspect.first} ${aspectName(aspect.type)} ${aspect.second}',
                  maxLines: compact ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (compact) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Orb ${formatAstrologyDegree(aspect.orb)}',
                    style: const TextStyle(
                      color: Color(0xFF817380),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 16),
            Text(
              'Orb ${formatAstrologyDegree(aspect.orb)}',
              style: const TextStyle(color: Color(0xFF817380), fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
