import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:uuid/uuid.dart';

class BarcodeView extends StatefulWidget {
  const BarcodeView({Key? key}) : super(key: key);

  @override
  _BarcodeViewState createState() => _BarcodeViewState();
}

class _BarcodeViewState extends State<BarcodeView> {
  late String uuid;

  @override
  void initState() {
    super.initState();
    generateAndSetUUID();
  }

  void generateAndSetUUID() {
    final uuidGenerator = Uuid();
    setState(() {
      uuid = uuidGenerator.v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BarcodeWidget(
              barcode: Barcode.code128(escapes: true),
              data: uuid,
              width: 200,
              height: 100,
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: generateAndSetUUID,
            //   child: Text('Generate New UUID'),
            // ),
          ],
        ),
      ),
    );
  }
}
