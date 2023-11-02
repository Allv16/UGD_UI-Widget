import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeView extends StatelessWidget {
  final String data;

  QRCodeView({required this.data, required int version, required double size});

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
            QRCodeView(data: data, version: QrVersions.auto, size: 200.0),
            SizedBox(height: 20),
            Text(
              'Data untuk QR Code: $data',
              style: TextStyle(fontSize: 18),
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