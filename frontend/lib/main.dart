import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/today_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    const SacredApp(),
  );
}

class SacredApp extends StatelessWidget {
  const SacredApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SACRED',
      debugShowCheckedModeBanner: false,
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
  }
}
