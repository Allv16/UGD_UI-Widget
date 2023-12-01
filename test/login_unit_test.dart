import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/main.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized(); // dapetin aset
    HttpOverrides.global = null; // api waktu texting
  });

  testWidgets('login', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const LoadLoginPage(),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key("emailField")), "alvian@");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("passwordField")), "12345");
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    ignoreException(PathNotFoundException);
    expect(find.text("Hi alvian!"), findsOneWidget);
  });
}

Future<void> ignoreException(Type exceptionType) async {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    if (errorDetails.exception.runtimeType == exceptionType) {
      return;
    }
    originalOnError!(errorDetails);
  };
}
