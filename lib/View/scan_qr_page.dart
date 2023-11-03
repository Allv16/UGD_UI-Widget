import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd_ui_widget/View/scanner_error_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPageView> createState() => BarcodeScannerPageViewState();
}

class BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;
  bool flashState = true;
  MobileScannerController scannerController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Scan barcode BPJS"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          cameraView(),
          Container(),
        ],
      ),
    );
  }

  Widget cameraView() {
    return Builder(builder: (context) {
      return Stack(
        children: [
          MobileScanner(
              startDelay: true,
              controller: scannerController,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) => setBarcodeCapture(capture)),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Text("scan disini"),
                Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(border: Border.all(width: 1.5)),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.primary),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        flashState = !flashState;
                        scannerController.toggleTorch();
                      });
                    },
                    icon: Icon(flashState ? Icons.flash_on : Icons.flash_off),
                    color: Colors.white,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  color: Colors.black.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 30,
                          child: FittedBox(
                            child: GestureDetector(
                              onTap: () => getURLResult(),
                              child: barcodeCaptureTextResult(context),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Text barcodeCaptureTextResult(BuildContext context) {
    return Text(
      barcodeCapture?.barcodes.first.rawValue ?? "masih mencari barcode..",
      overflow: TextOverflow.fade,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(color: Colors.white),
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    setState(() {
      barcodeCapture = capture;
    });
  }

  void getURLResult() {
    final qrCode = barcodeCapture?.barcodes.first.rawValue;
    if (qrCode != null) {
      Navigator.pop(context, qrCode);
    }
  }

  void copyToClipboard(String text) {
    Navigator.pop(context, barcodeCapture?.barcodes.first.rawValue);
  }
}
