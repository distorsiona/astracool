import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/generated/app_localizations.dart';
import 'l10n/locale_controller.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/today_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeController = await LocaleController.initial();

  runApp(
    SacredApp(localeController: localeController),
  );
}

class SacredApp extends StatelessWidget {
  final LocaleController localeController;

  const SacredApp({
    super.key,
    required this.localeController,
  });

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      controller: localeController,
      child: AnimatedBuilder(
        animation: localeController,
        builder: (context, _) {
          return MaterialApp(
            title: 'SACRED',
            debugShowCheckedModeBanner: false,
            locale: localeController.value,
            supportedLocales: LocaleController.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/login',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/today': (context) => const TodayScreen(
                    userId: '',
                  ),
              '/profile': (context) => const ProfileScreen(
                    userId: '',
                  ),
            },
          );
        },
      ),
    );
  }
}
