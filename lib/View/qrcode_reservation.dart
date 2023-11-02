import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeView extends StatelessWidget {
  const QRCodeView({super.key});

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