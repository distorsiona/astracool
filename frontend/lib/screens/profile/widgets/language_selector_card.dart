import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../l10n/locale_controller.dart';
import '../helpers/profile_card_decoration.dart';

// selector de idioma dentro de Profile.
//
// se ubica al final de la pantalla, junto a las demás acciones,
// para no interferir con el resto del layout responsive.
class LanguageSelectorCard extends StatelessWidget {
  final Color accentColor;
  final bool mobile;

  const LanguageSelectorCard({
    super.key,
    required this.accentColor,
    this.mobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = LocaleScope.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final currentCode = controller.value.languageCode;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 20 : 40,
            vertical: mobile ? 22 : 28,
          ),
          decoration: profileCardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.languageSectionTitle,
                style: TextStyle(
                  color: accentColor,
                  fontSize: mobile ? 13 : 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: mobile ? 14 : 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _LanguageOption(
                    label: l10n.languageEnglish,
                    selected: currentCode == 'en',
                    accentColor: accentColor,
                    onTap: () => controller.setLocale(const Locale('en')),
                  ),
                  _LanguageOption(
                    label: l10n.languageSpanish,
                    selected: currentCode == 'es',
                    accentColor: accentColor,
                    onTap: () => controller.setLocale(const Locale('es')),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final Color accentColor;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? accentColor.withAlpha(20) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? accentColor : const Color(0xFFD6D2CB),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? accentColor : const Color(0xFF252525),
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
