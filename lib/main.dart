import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_ui_widget/View/payment_history.dart';
import 'package:ugd_ui_widget/View/edit_reservation_success.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';

void main() {
  // if(Platform.isWindows){
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }

  WidgetsFlutterBinding.ensureInitialized();


  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
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
        home: PaymentHistoryPage(),
      );
    });
  }
}
