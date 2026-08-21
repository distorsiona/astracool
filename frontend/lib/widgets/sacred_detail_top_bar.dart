import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

class SacredDetailTopBar extends StatelessWidget {
  final Color accentColor;
  final String trailingLabel;
  final VoidCallback onBack;

  const SacredDetailTopBar({
    super.key,
    required this.accentColor,
    required this.trailingLabel,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 430;

        return Container(
          constraints: const BoxConstraints(minHeight: 62),
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 8 : 14,
            vertical: 7,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F1EE),
            border: Border(bottom: BorderSide(color: Color(0xFFEAE1E8))),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                tooltip: AppLocalizations.of(context)!.backTooltip,
                icon: const Icon(Icons.arrow_back),
              ),
              SizedBox(width: narrow ? 2 : 6),
              Flexible(
                child: Text(
                  'Sacred',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: accentColor,
                    fontFamily: 'serif',
                    fontSize: narrow ? 18 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                trailingLabel,
                maxLines: 1,
                style: TextStyle(
                  color: accentColor,
                  fontSize: narrow ? 8 : 9,
                  letterSpacing: narrow ? 1.3 : 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
