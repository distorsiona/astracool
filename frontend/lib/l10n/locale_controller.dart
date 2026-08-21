import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// controla el idioma actual de la app y lo persiste localmente.
//
// arranque:
// 1. si el usuario ya eligió un idioma antes, se respeta.
// 2. si no, se usa el idioma del dispositivo si es "es" o "en".
// 3. si no es ninguno de los dos, se usa inglés.
class LocaleController extends ValueNotifier<Locale> {
  LocaleController(super.value);

  static const supportedLocales = [Locale('en'), Locale('es')];

  static const _prefsKey = 'app_locale';

  static Future<LocaleController> initial() async {
    final prefs = await SharedPreferences.getInstance();

    final saved = prefs.getString(_prefsKey);

    if (saved != null && _isSupported(saved)) {
      return LocaleController(Locale(saved));
    }

    final deviceCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return LocaleController(
      Locale(_isSupported(deviceCode) ? deviceCode : 'en'),
    );
  }

  static bool _isSupported(String languageCode) {
    return supportedLocales.any(
      (locale) => locale.languageCode == languageCode,
    );
  }

  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale.languageCode)) {
      return;
    }

    value = locale;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_prefsKey, locale.languageCode);
  }
}

// permite acceder al LocaleController desde cualquier pantalla
// sin pasarlo manualmente por el árbol de widgets.
class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    super.key,
    required LocaleController controller,
    required super.child,
  }) : super(notifier: controller);

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();

    assert(scope != null, 'LocaleScope not found in context');

    return scope!.notifier!;
  }
}
