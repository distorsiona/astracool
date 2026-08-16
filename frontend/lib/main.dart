import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(
    const AstraApp(),
  );
}

class AstraApp extends StatelessWidget {
  const AstraApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASTRA',
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',

      routes: {
        '/login': (context) =>
            const LoginScreen(),

        '/register': (context) =>
            const RegisterScreen(),
      },
    );
  }
}