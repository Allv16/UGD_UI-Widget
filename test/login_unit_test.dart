import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/main.dart';

void main() {
  testWidgets('loginn', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const LoadLoginPage(),
    ));
  });
}
