// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flavor_text/flavor_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display a simple string', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FlavorText('Hello <style color="0xFFFF0000">world</style>!'),
    ));

    // Verify that the text is rendered.
    expect(find.text('Hello world!'), findsOneWidget);
  });
}
