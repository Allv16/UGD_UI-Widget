import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/View/qrcode_reservation.dart';
import 'View/my_reservation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return ResponsiveSizer(builder: (context, orientation, deviceType){
        Device.orientation == Orientation.portrait
          ? Container(
            width: 100.w,
            height: 20.5.h,
        )
            : Container(
              width: 100.w,
              height: 12.5.h,
        );
        Device.screenType == ScreenType.tablet
          ? Container(
            width: 100.w,
            height: 20.5.h,
        )
            : Container(
              width: 100.w,
              height: 12.5.h,
        );
      
        return MaterialApp(
          title: 'WeCare',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
              primary: const Color(0xFF1B90B8),
            ).copyWith(
              secondary: Colors.blue,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1B90B8)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
          ))),
          home: LoginView(),
        );
      },
    );
  }
}


