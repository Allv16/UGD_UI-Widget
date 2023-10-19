import 'package:flutter/material.dart';
// import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const MyReservation(),
    );
  }
}
