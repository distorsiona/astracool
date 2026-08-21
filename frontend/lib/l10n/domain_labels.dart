import 'package:flutter/widgets.dart';

import '../models/zodiac_profile_model.dart';
import 'generated/app_localizations.dart';

// ============================================================
// CAPA DE PRESENTACIÓN DE VALORES DE DOMINIO
//
// El backend (y varias comparaciones internas: ZodiacTheme,
// planetSymbol(), aspectSymbol(), etc.) siguen usando strings
// fijos en inglés como 'Scorpio', 'Sun' o 'VERY HIGH'.
//
// Estas funciones NUNCA modifican ese valor de dominio: solo
// devuelven el texto que se muestra al usuario según el idioma
// activo. Si el backend envía un valor no reconocido, se
// devuelve el valor original tal cual (fallback seguro), para
// no romper la UI ante datos nuevos o inesperados.
// ============================================================

String localizedSignName(BuildContext context, String sign) {
  final l10n = AppLocalizations.of(context)!;

  switch (sign.trim().toLowerCase()) {
    case 'aries':
      return l10n.signAries;
    case 'taurus':
      return l10n.signTaurus;
    case 'gemini':
      return l10n.signGemini;
    case 'cancer':
      return l10n.signCancer;
    case 'leo':
      return l10n.signLeo;
    case 'virgo':
      return l10n.signVirgo;
    case 'libra':
      return l10n.signLibra;
    case 'scorpio':
      return l10n.signScorpio;
    case 'sagittarius':
      return l10n.signSagittarius;
    case 'capricorn':
      return l10n.signCapricorn;
    case 'aquarius':
      return l10n.signAquarius;
    case 'pisces':
      return l10n.signPisces;
    default:
      return sign;
  }
}

String localizedSignDateRange(BuildContext context, String sign) {
  final l10n = AppLocalizations.of(context)!;

  switch (sign.trim().toLowerCase()) {
    case 'aries':
      return l10n.signDateRangeAries;
    case 'taurus':
      return l10n.signDateRangeTaurus;
    case 'gemini':
      return l10n.signDateRangeGemini;
    case 'cancer':
      return l10n.signDateRangeCancer;
    case 'leo':
      return l10n.signDateRangeLeo;
    case 'virgo':
      return l10n.signDateRangeVirgo;
    case 'libra':
      return l10n.signDateRangeLibra;
    case 'scorpio':
      return l10n.signDateRangeScorpio;
    case 'sagittarius':
      return l10n.signDateRangeSagittarius;
    case 'capricorn':
      return l10n.signDateRangeCapricorn;
    case 'aquarius':
      return l10n.signDateRangeAquarius;
    case 'pisces':
      return l10n.signDateRangePisces;
    default:
      return '';
  }
}

String localizedPlanetName(BuildContext context, String planet) {
  final l10n = AppLocalizations.of(context)!;

  switch (planet.trim().toLowerCase()) {
    case 'sun':
      return l10n.planetSun;
    case 'moon':
      return l10n.planetMoon;
    case 'mercury':
      return l10n.planetMercury;
    case 'venus':
      return l10n.planetVenus;
    case 'mars':
      return l10n.planetMars;
    case 'jupiter':
      return l10n.planetJupiter;
    case 'saturn':
      return l10n.planetSaturn;
    case 'uranus':
      return l10n.planetUranus;
    case 'neptune':
      return l10n.planetNeptune;
    case 'pluto':
      return l10n.planetPluto;
    case 'node':
    case 'north node':
      return l10n.planetNorthNode;
    case 'chiron':
      return l10n.planetChiron;
    case 'part of fortune':
      return l10n.planetPartOfFortune;
    case 'lilith':
      return l10n.planetLilith;
    case 'ascendant':
      return l10n.planetAscendant;
    case 'midheaven':
      return l10n.planetMidheaven;
    default:
      return planet;
  }
}

// variante para cuando el elemento llega como String suelto desde el
// backend (ej. ChartProfile.element), en vez del enum ZodiacElement.
String localizedElementLabel(BuildContext context, String element) {
  final l10n = AppLocalizations.of(context)!;

  switch (element.trim().toLowerCase()) {
    case 'fire':
      return l10n.elementFire;
    case 'earth':
      return l10n.elementEarth;
    case 'air':
      return l10n.elementAir;
    case 'water':
      return l10n.elementWater;
    default:
      return element;
  }
}

// variante para cuando la modalidad llega como String suelto desde el
// backend (ej. ChartProfile.modality), en vez del enum ZodiacModality.
String localizedModalityLabel(BuildContext context, String modality) {
  final l10n = AppLocalizations.of(context)!;

  switch (modality.trim().toLowerCase()) {
    case 'cardinal':
      return l10n.modalityCardinal;
    case 'fixed':
      return l10n.modalityFixed;
    case 'mutable':
      return l10n.modalityMutable;
    default:
      return modality;
  }
}

String localizedElementName(BuildContext context, ZodiacElement element) {
  final l10n = AppLocalizations.of(context)!;

  switch (element) {
    case ZodiacElement.fire:
      return l10n.elementFire;
    case ZodiacElement.earth:
      return l10n.elementEarth;
    case ZodiacElement.air:
      return l10n.elementAir;
    case ZodiacElement.water:
      return l10n.elementWater;
  }
}

String localizedModalityName(BuildContext context, ZodiacModality modality) {
  final l10n = AppLocalizations.of(context)!;

  switch (modality) {
    case ZodiacModality.cardinal:
      return l10n.modalityCardinal;
    case ZodiacModality.fixed:
      return l10n.modalityFixed;
    case ZodiacModality.mutable:
      return l10n.modalityMutable;
  }
}

String localizedAspectName(BuildContext context, String type) {
  final l10n = AppLocalizations.of(context)!;

  switch (type.trim().toLowerCase()) {
    case 'conjunction':
      return l10n.aspectConjunction;
    case 'opposition':
      return l10n.aspectOpposition;
    case 'square':
      return l10n.aspectSquare;
    case 'trine':
      return l10n.aspectTrine;
    case 'sextile':
      return l10n.aspectSextile;
    default:
      return type;
  }
}

// nivel de actividad de una casa (HouseActivityModel.level).
String localizedActivityLevel(BuildContext context, String level) {
  final l10n = AppLocalizations.of(context)!;

  switch (level.trim().toUpperCase()) {
    case 'VERY HIGH':
      return l10n.levelVeryHigh;
    case 'HIGH':
      return l10n.levelHigh;
    case 'MEDIUM':
      return l10n.levelMedium;
    case 'LOW':
      return l10n.levelLow;
    default:
      return level;
  }
}

// título de una casa (HouseModel.title, ChartHouse.title, FeaturedHouse.title).
//
// Se indexa por número de casa (1-12) y NO por el texto en inglés que
// manda el backend: /chart y /houses usan dos diccionarios HOUSE_INFO
// ligeramente distintos entre sí (ej. casa 12 es "House of the Inner
// World" en uno y "House of Inner Life" en el otro), así que matchear
// por string se rompería según el endpoint. `fallback` es el título
// original tal como llegó, usado solo si el número de casa no es 1-12.
String localizeHouseTitle(
  BuildContext context,
  int houseNumber,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (houseNumber) {
    case 1:
      return l10n.houseTitle1;
    case 2:
      return l10n.houseTitle2;
    case 3:
      return l10n.houseTitle3;
    case 4:
      return l10n.houseTitle4;
    case 5:
      return l10n.houseTitle5;
    case 6:
      return l10n.houseTitle6;
    case 7:
      return l10n.houseTitle7;
    case 8:
      return l10n.houseTitle8;
    case 9:
      return l10n.houseTitle9;
    case 10:
      return l10n.houseTitle10;
    case 11:
      return l10n.houseTitle11;
    case 12:
      return l10n.houseTitle12;
    default:
      return fallback;
  }
}

// subtítulo de una casa (HouseModel.subtitle, ChartHouse.subtitle,
// FeaturedHouse.subtitle). Mismo criterio que localizeHouseTitle: se
// indexa por número de casa, no por el texto en inglés.
String localizeHouseSubtitle(
  BuildContext context,
  int houseNumber,
  String fallback,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (houseNumber) {
    case 1:
      return l10n.houseSubtitle1;
    case 2:
      return l10n.houseSubtitle2;
    case 3:
      return l10n.houseSubtitle3;
    case 4:
      return l10n.houseSubtitle4;
    case 5:
      return l10n.houseSubtitle5;
    case 6:
      return l10n.houseSubtitle6;
    case 7:
      return l10n.houseSubtitle7;
    case 8:
      return l10n.houseSubtitle8;
    case 9:
      return l10n.houseSubtitle9;
    case 10:
      return l10n.houseSubtitle10;
    case 11:
      return l10n.houseSubtitle11;
    case 12:
      return l10n.houseSubtitle12;
    default:
      return fallback;
  }
}

// keyword/theme individual de una casa (HouseModel.keywords,
// FeaturedHouse.themes). Se traduce palabra por palabra, ANTES de
// hacer el `.join(' · ')` en el widget, cubriendo las variantes que
// usan los dos diccionarios HOUSE_INFO del backend (ej. "Wellbeing"
// vs "Well-being", "Friends" vs "Friendships").
String localizeHouseKeyword(BuildContext context, String keyword) {
  final l10n = AppLocalizations.of(context)!;

  switch (keyword.trim().toLowerCase()) {
    case 'identity':
      return l10n.houseKeywordIdentity;
    case 'appearance':
      return l10n.houseKeywordAppearance;
    case 'first impressions':
      return l10n.houseKeywordFirstImpressions;
    case 'money':
      return l10n.houseKeywordMoney;
    case 'values':
      return l10n.houseKeywordValues;
    case 'self-worth':
      return l10n.houseKeywordSelfWorth;
    case 'communication':
      return l10n.houseKeywordCommunication;
    case 'learning':
      return l10n.houseKeywordLearning;
    case 'thinking':
      return l10n.houseKeywordThinking;
    case 'siblings':
      return l10n.houseKeywordSiblings;
    case 'home':
      return l10n.houseKeywordHome;
    case 'family':
      return l10n.houseKeywordFamily;
    case 'roots':
      return l10n.houseKeywordRoots;
    case 'creativity':
      return l10n.houseKeywordCreativity;
    case 'romance':
      return l10n.houseKeywordRomance;
    case 'pleasure':
      return l10n.houseKeywordPleasure;
    case 'routine':
      return l10n.houseKeywordRoutine;
    case 'work':
      return l10n.houseKeywordWork;
    case 'well-being':
    case 'wellbeing':
      return l10n.houseKeywordWellbeing;
    case 'relationships':
      return l10n.houseKeywordRelationships;
    case 'partnerships':
      return l10n.houseKeywordPartnerships;
    case 'commitment':
      return l10n.houseKeywordCommitment;
    case 'intimacy':
      return l10n.houseKeywordIntimacy;
    case 'trust':
      return l10n.houseKeywordTrust;
    case 'transformation':
      return l10n.houseKeywordTransformation;
    case 'shared resources':
      return l10n.houseKeywordSharedResources;
    case 'beliefs':
      return l10n.houseKeywordBeliefs;
    case 'travel':
      return l10n.houseKeywordTravel;
    case 'higher learning':
      return l10n.houseKeywordHigherLearning;
    case 'career':
      return l10n.houseKeywordCareer;
    case 'reputation':
      return l10n.houseKeywordReputation;
    case 'purpose':
      return l10n.houseKeywordPurpose;
    case 'friendships':
      return l10n.houseKeywordFriendships;
    case 'friends':
      return l10n.houseKeywordFriends;
    case 'community':
      return l10n.houseKeywordCommunity;
    case 'future goals':
      return l10n.houseKeywordFutureGoals;
    case 'goals':
      return l10n.houseKeywordGoals;
    case 'inner world':
      return l10n.houseKeywordInnerWorld;
    case 'subconscious':
      return l10n.houseKeywordSubconscious;
    case 'solitude':
      return l10n.houseKeywordSolitude;
    default:
      return keyword;
  }
}

// fuerza de un aspecto/influencia (HouseInfluence.strength,
// ChartHouse.strengthLabel).
String localizedStrength(BuildContext context, String strength) {
  if (strength.trim().isEmpty) {
    return '';
  }

  final l10n = AppLocalizations.of(context)!;

  switch (strength.trim().toLowerCase()) {
    case 'very strong':
      return l10n.strengthVeryStrong;
    case 'strong':
      return l10n.strengthStrong;
    case 'moderate':
      return l10n.strengthModerate;
    case 'wide':
      return l10n.strengthWide;
    default:
      return strength;
  }
}
