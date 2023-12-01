import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/main.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
  });

  testWidgets('create reservation', (tester) async {
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
    ignoreException(PathNotFoundException);
    await tester.tap(find.text('Booking'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("datePicker")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("timePicker")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('bpjsField')), '1234123412341');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Success'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
  testWidgets('read reservation', (tester) async {
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
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    ignoreException(PathNotFoundException);
    await tester.tap(find.text('Booking'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.text('BPJS'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
  testWidgets('edit reservation', (tester) async {
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
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    ignoreException(PathNotFoundException);
    await tester.tap(find.text('Booking'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byIcon(Icons.create_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("datePicker")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("timePicker")).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('AM'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('bpjsField')), '');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('BPJS'), findsNothing);
  });
  testWidgets('delete reservation', (tester) async {
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
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    ignoreException(PathNotFoundException);
    await tester.tap(find.text('Booking'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
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
