import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/login.dart';

void main() {
  RunApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
