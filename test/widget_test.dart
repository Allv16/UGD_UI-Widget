import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/View/login.dart';

void main() {
  //biar bisa testing http request
  setUpAll(() {
    HttpOverrides.global = null; //hubungkan flutter utk akses api
  });

  testWidgets('Addition calculation test', (WidgetTester tester) async {
    await tester.pumpWidget(ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'We Care',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
              primary: const Color(0xFF1B90B8),
            ),
          ),
          home: const LoginView(),
        );
      },
    ));

    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("email")), "123");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("password")), "123");
    await tester.pumpAndSettle();
    await tester.tap(find.text("login"));

    await ignoreException(PathNotFoundException);

    await tester.pumpAndSettle();
    expect(find.text("Find Your Doctor", skipOffstage: false), findsOneWidget);
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
