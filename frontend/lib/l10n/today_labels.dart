import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/today_model.dart';
import '../utils/astrology_symbols.dart';
import 'domain_labels.dart';
import 'generated/app_localizations.dart';

// ============================================================
// CAPA DE TRADUCCIÓN PARA "TODAY"
//
// El endpoint /api/today arma todo su contenido (subtítulos,
// frases, casas afectadas, tránsitos, foco, interpretación) a
// partir de plantillas y diccionarios fijos en inglés dentro de
// TodayService. Nada de eso es texto libre generado por un LLM:
// siempre sale de un conjunto conocido de valores (signo, casa,
// aspecto, planeta).
//
// Por eso, en vez de traducir el string en inglés que llega del
// backend, estas funciones reconstruyen el mismo texto usando
// los valores de dominio (sign, house number, first/aspect/second)
// y los strings localizados de AppLocalizations. Si el backend
// manda un valor no reconocido, se devuelve el texto original
// como fallback seguro, igual que en domain_labels.dart.
// ============================================================

String localizedTodayMoonSubtitle(
  BuildContext context,
  String sign,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (sign.trim().toLowerCase()) {
    case 'aries':
      return l10n.todayMoonSubtitleAries;
    case 'taurus':
      return l10n.todayMoonSubtitleTaurus;
    case 'gemini':
      return l10n.todayMoonSubtitleGemini;
    case 'cancer':
      return l10n.todayMoonSubtitleCancer;
    case 'leo':
      return l10n.todayMoonSubtitleLeo;
    case 'virgo':
      return l10n.todayMoonSubtitleVirgo;
    case 'libra':
      return l10n.todayMoonSubtitleLibra;
    case 'scorpio':
      return l10n.todayMoonSubtitleScorpio;
    case 'sagittarius':
      return l10n.todayMoonSubtitleSagittarius;
    case 'capricorn':
      return l10n.todayMoonSubtitleCapricorn;
    case 'aquarius':
      return l10n.todayMoonSubtitleAquarius;
    case 'pisces':
      return l10n.todayMoonSubtitlePisces;
    default:
      return fallback.isNotEmpty
          ? fallback
          : l10n.todayMoonSubtitleDefault;
  }
}

String localizedTodayQuote(
  BuildContext context,
  String sign,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (sign.trim().toLowerCase()) {
    case 'aries':
      return l10n.todayQuoteAries;
    case 'taurus':
      return l10n.todayQuoteTaurus;
    case 'gemini':
      return l10n.todayQuoteGemini;
    case 'cancer':
      return l10n.todayQuoteCancer;
    case 'leo':
      return l10n.todayQuoteLeo;
    case 'virgo':
      return l10n.todayQuoteVirgo;
    case 'libra':
      return l10n.todayQuoteLibra;
    case 'scorpio':
      return l10n.todayQuoteScorpio;
    case 'sagittarius':
      return l10n.todayQuoteSagittarius;
    case 'capricorn':
      return l10n.todayQuoteCapricorn;
    case 'aquarius':
      return l10n.todayQuoteAquarius;
    case 'pisces':
      return l10n.todayQuotePisces;
    default:
      return fallback.isNotEmpty ? fallback : l10n.todayQuoteDefault;
  }
}

String localizedTodayLuckyColor(
  BuildContext context,
  String sign,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (sign.trim().toLowerCase()) {
    case 'aries':
      return l10n.todayLuckyColorAries;
    case 'taurus':
      return l10n.todayLuckyColorTaurus;
    case 'gemini':
      return l10n.todayLuckyColorGemini;
    case 'cancer':
      return l10n.todayLuckyColorCancer;
    case 'leo':
      return l10n.todayLuckyColorLeo;
    case 'virgo':
      return l10n.todayLuckyColorVirgo;
    case 'libra':
      return l10n.todayLuckyColorLibra;
    case 'scorpio':
      return l10n.todayLuckyColorScorpio;
    case 'sagittarius':
      return l10n.todayLuckyColorSagittarius;
    case 'capricorn':
      return l10n.todayLuckyColorCapricorn;
    case 'aquarius':
      return l10n.todayLuckyColorAquarius;
    case 'pisces':
      return l10n.todayLuckyColorPisces;
    default:
      return fallback.isNotEmpty
          ? fallback
          : l10n.todayLuckyColorDefault;
  }
}

String localizedTodayThemeName(
  BuildContext context,
  String name,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (name.trim().toLowerCase()) {
    case 'love':
      return l10n.todayThemeLove;
    case 'energy':
      return l10n.todayThemeEnergy;
    case 'work':
      return l10n.todayThemeWork;
    case 'emotions':
      return l10n.todayThemeEmotions;
    default:
      return name;
  }
}

// ============================================================
// CASAS AFECTADAS (keyed por número de casa, 1-12)
// ============================================================

String localizedTodayHouseTitle(
  BuildContext context,
  int number,
) {
  final l10n = AppLocalizations.of(context)!;

  return l10n.todayHouseTitleTemplate(romanNumeral(number));
}

String localizedTodayHouseSubtitle(
  BuildContext context,
  int number,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (number) {
    case 1:
      return l10n.todayHouseSubtitle1;
    case 2:
      return l10n.todayHouseSubtitle2;
    case 3:
      return l10n.todayHouseSubtitle3;
    case 4:
      return l10n.todayHouseSubtitle4;
    case 5:
      return l10n.todayHouseSubtitle5;
    case 6:
      return l10n.todayHouseSubtitle6;
    case 7:
      return l10n.todayHouseSubtitle7;
    case 8:
      return l10n.todayHouseSubtitle8;
    case 9:
      return l10n.todayHouseSubtitle9;
    case 10:
      return l10n.todayHouseSubtitle10;
    case 11:
      return l10n.todayHouseSubtitle11;
    case 12:
      return l10n.todayHouseSubtitle12;
    default:
      return fallback;
  }
}

String localizedTodayHouseDescription(
  BuildContext context,
  int number,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (number) {
    case 1:
      return l10n.todayHouseDescription1;
    case 2:
      return l10n.todayHouseDescription2;
    case 3:
      return l10n.todayHouseDescription3;
    case 4:
      return l10n.todayHouseDescription4;
    case 5:
      return l10n.todayHouseDescription5;
    case 6:
      return l10n.todayHouseDescription6;
    case 7:
      return l10n.todayHouseDescription7;
    case 8:
      return l10n.todayHouseDescription8;
    case 9:
      return l10n.todayHouseDescription9;
    case 10:
      return l10n.todayHouseDescription10;
    case 11:
      return l10n.todayHouseDescription11;
    case 12:
      return l10n.todayHouseDescription12;
    default:
      return fallback;
  }
}

// ============================================================
// TRÁNSITOS
//
// title/description/status se reconstruyen desde first/aspect/
// second/isExactToday/exactTime en vez de traducir el string
// armado por el backend.
// ============================================================

String _todayTransitTone(
  BuildContext context,
  String aspect,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (aspect.trim().toLowerCase()) {
    case 'trine':
      return l10n.todayTransitToneTrine;
    case 'sextile':
      return l10n.todayTransitToneSextile;
    case 'square':
      return l10n.todayTransitToneSquare;
    case 'opposition':
      return l10n.todayTransitToneOpposition;
    case 'conjunction':
      return l10n.todayTransitToneConjunction;
    default:
      return l10n.todayTransitToneDefault;
  }
}

String localizedTransitTitle(
  BuildContext context,
  TodayTransit transit,
) {
  final l10n = AppLocalizations.of(context)!;

  return l10n.todayTransitTitleTemplate(
    localizedPlanetName(context, transit.first),
    localizedAspectName(context, transit.aspect),
    localizedPlanetName(context, transit.second),
  );
}

String localizedTransitDescription(
  BuildContext context,
  TodayTransit transit,
) {
  final l10n = AppLocalizations.of(context)!;

  return l10n.todayTransitDescriptionTemplate(
    localizedPlanetName(context, transit.first),
    localizedPlanetName(context, transit.second),
    _todayTransitTone(context, transit.aspect),
  );
}

String localizedTransitStatus(
  BuildContext context,
  TodayTransit transit,
) {
  final l10n = AppLocalizations.of(context)!;

  if (transit.isExactToday) {
    return l10n.todayTransitStatusExactToday;
  }

  final rawExactTime = transit.exactTime;

  if (rawExactTime != null && rawExactTime.trim().isNotEmpty) {
    try {
      final exactDate = DateTime.parse(
        rawExactTime.trim().replaceFirst(' ', 'T'),
      );

      final languageCode = Localizations.localeOf(context).languageCode;

      final formatted = DateFormat('MMM d', languageCode).format(exactDate);

      return l10n.todayTransitStatusActiveExact(formatted);
    } catch (_) {
      // si no se puede parsear la fecha, cae al estado genérico.
    }
  }

  return l10n.todayTransitStatusActive;
}

// ============================================================
// FOCO DE HOY
//
// El backend arma "focus" a partir del primer tránsito de la
// lista ya ordenada (el mismo que queda en transits.first), así
// que se reconstruye igual acá en vez de traducir el texto.
// ============================================================

String localizedTodayFocus(
  BuildContext context,
  List<TodayTransit> transits,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  if (transits.isEmpty) {
    return fallback.isNotEmpty ? fallback : l10n.todayFocusDefault;
  }

  final transit = transits.first;

  return l10n.todayFocusTemplate(
    localizedPlanetName(context, transit.first),
    localizedAspectName(context, transit.aspect),
    localizedPlanetName(context, transit.second),
  );
}

// ============================================================
// INTERPRETACIÓN DEL DÍA
//
// Reconstruye el párrafo de "tu energía hoy" a partir de los
// mismos datos estructurados que usa TodayService._build_interpretation
// (moon_sign, affected_houses, transits), en vez de traducir el
// texto en inglés ya armado.
// ============================================================

String localizedTodayInterpretation(
  BuildContext context,
  TodayModel data,
) {
  final l10n = AppLocalizations.of(context)!;

  final moonSign = data.moonSign.trim();

  final exactToday =
      data.transits.where((transit) => transit.isExactToday).toList();

  String houseClause = '';

  if (data.affectedHouses.isNotEmpty) {
    final primaryHouse = data.affectedHouses.first;

    final houseTitle = localizedTodayHouseTitle(
      context,
      primaryHouse.number,
    );

    final houseSubtitle = localizedTodayHouseSubtitle(
      context,
      primaryHouse.number,
      primaryHouse.subtitle,
    ).toLowerCase();

    final houseSentence = l10n.todayInterpretationHouseClause(
      houseTitle,
      houseSubtitle,
    );

    houseClause = ' $houseSentence';
  }

  // ==========================================================
  // TRÁNSITOS EXACTOS HOY
  // ==========================================================

  if (exactToday.isNotEmpty) {
    final main = exactToday.first;
    final second = exactToday.length > 1 ? exactToday[1] : null;

    var text = '';

    if (moonSign.isNotEmpty) {
      text += l10n.todayInterpretationMoonIntroExact(
        localizedSignName(context, moonSign),
      );
    }

    text += houseClause;

    final mainPattern = l10n.todayInterpretationMainPattern(
      localizedTransitTitle(context, main),
    );

    text += ' $mainPattern';

    if (second != null) {
      final secondPattern = l10n.todayInterpretationSecondPattern(
        localizedTransitTitle(context, second),
      );

      text += ' $secondPattern';
    }

    text += ' ${l10n.todayInterpretationClosing}';

    return text.trim();
  }

  // ==========================================================
  // ACTIVOS PERO NO EXACTOS
  // ==========================================================

  if (data.transits.isNotEmpty) {
    final strongest = data.transits.first;

    var text = '';

    if (moonSign.isNotEmpty) {
      text += l10n.todayInterpretationMoonIntroActive(
        localizedSignName(context, moonSign),
      );
    }

    text += houseClause;

    final strongestPattern = l10n.todayInterpretationStrongestPattern(
      localizedTransitTitle(context, strongest),
    );

    text += ' $strongestPattern';

    return text.trim();
  }

  // ==========================================================
  // DÍA TRANQUILO
  // ==========================================================

  if (moonSign.isNotEmpty) {
    return l10n.todayInterpretationQuietWithMoon(
      localizedSignName(context, moonSign),
    );
  }

  return l10n.todayInterpretationQuietNoMoon;
}
