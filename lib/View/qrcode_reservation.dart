import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';

class QRCodeView extends StatefulWidget {
  const QRCodeView({Key? key}) : super(key: key);

  @override
  _QRCodeViewState createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {

  @override
  void initState() {
    super.initState();
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('QR Code View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: 'https://pub.dev/packages/qr_flutter',
              version: 6,
              padding: const EdgeInsets.all(50),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() => runApp(MaterialApp(
//       title: 'QR Code Example',
//       home: QRCodeView(data: 'Contoh Data'), // Ganti 'Contoh Data' dengan data yang ingin ditampilkan dalam QR code
//     ));