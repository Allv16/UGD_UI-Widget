import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('loginn', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const LoadLoginPage(),
    ));

    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("emailField")), "123@");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("passwordField")), "12345");
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text("Hi alvian!"), findsOneWidget);
  });
}
