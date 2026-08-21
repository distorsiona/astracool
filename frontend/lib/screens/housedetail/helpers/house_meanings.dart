import 'package:flutter/widgets.dart';

import '../../../l10n/generated/app_localizations.dart';

// significado base de las casas
//
// esto sirve mientras backend mande meaning vacío.
String defaultHouseMeaning(BuildContext context, int house) {
  final l10n = AppLocalizations.of(context)!;

  switch (house) {
    case 1:
      return l10n.houseMeaning1;
    case 2:
      return l10n.houseMeaning2;
    case 3:
      return l10n.houseMeaning3;
    case 4:
      return l10n.houseMeaning4;
    case 5:
      return l10n.houseMeaning5;
    case 6:
      return l10n.houseMeaning6;
    case 7:
      return l10n.houseMeaning7;
    case 8:
      return l10n.houseMeaning8;
    case 9:
      return l10n.houseMeaning9;
    case 10:
      return l10n.houseMeaning10;
    case 11:
      return l10n.houseMeaning11;
    case 12:
      return l10n.houseMeaning12;
    default:
      return l10n.houseMeaningDefault;
  }
}
