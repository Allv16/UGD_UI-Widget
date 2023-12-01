import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/View/register.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/main.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized(); // dapetin aset
    HttpOverrides.global = null; // api waktu texting
  });

  testWidgets('register', (tester) async {
    await tester.pumpWidget(ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'WeCare',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
              primary: const Color(0xFF1B90B8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF1B90B8)),
            ))),
        home: const RegisterView(),
      );
    } 
    ));

    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(find.byKey(const Key("usernameField")), "alvian");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("telpField")), "1234567891011");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("emailField")), "123@");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("passwordField")), "12345");
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DatePicker));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.byType(ElevatedButton).first, find.byType(SingleChildScrollView),const Offset(0,100));
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    // ignoreException(PathNotFoundException);
    expect(find.text("Login"), findsOneWidget);
  });
}

// Future<void> ignoreException(Type exceptionType) async {
//   final originalOnError = FlutterError.onError;
//   FlutterError.onError = (FlutterErrorDetails errorDetails) async {
//     if (errorDetails.exception.runtimeType == exceptionType) {
//       return;
//     }
//     originalOnError!(errorDetails);
//   };
// }
