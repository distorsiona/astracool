import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets(
    'ProfileScreen loads correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const AstrologyApp(),
      );

      expect(
        find.text('PROFILE'),
        findsOneWidget,
      );
    },
  );
}