import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/l10n/locale_controller.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets(
    'ProfileScreen loads correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        SacredApp(localeController: LocaleController(const Locale('en'))),
      );

      expect(
        find.text('PROFILE'),
        findsOneWidget,
      );
    },
  );
}
