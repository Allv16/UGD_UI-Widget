import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/preview_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ugd_ui_widget/model/payment.dart';

Future<void> createPdf(Payments payment, BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  final imageLogo =
      (await rootBundle.load("images/banner.png")).buffer.asUint8List();

  doc.addPage(
    pw.MultiPage(
      build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Image(pw.MemoryImage(imageLogo),
                    width: 500), // Show the image
              ),
              pw.SizedBox(height: 1.1 * PdfPageFormat.cm),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Text(
                '    Detail Payment',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
              pw.Text(
                '        Doctor     :   ${payment.reservation.praktek.dokter.nama}',
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.normal),
              ),
              pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
              pw.Text(
                '        Visit Time      :   ${payment.reservation.praktek.jamPraktek} WIB',
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.normal),
              ),
              pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
              pw.Text(
                '        Reservation Date      :   ${payment.reservation.date}',
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.normal),
              ),
              pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
              pw.Text(
                '        Total amount      :   ${payment.amount}',
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.normal),
              ),
              pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
              pw.Text(
                '        Payment Type      :   ${payment.jenisPembayaran}',
                style: pw.TextStyle(
                    fontSize: 15, fontWeight: pw.FontWeight.normal),
              ),
              pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
              pw.Container(
                alignment: pw.Alignment.center,
                child: barcodeGaris(payment.reservation.id.toString()),
              ),
            ],
          )
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#FFBD59'),
            child: footerPDF(formattedDate));
      },
    ),
  );
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)));
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 200,
        height: 100,
      ),
    ),
  );
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
          shape: pw.BoxShape.rectangle,
          gradient: pw.LinearGradient(
              colors: [PdfColors.blue100, PdfColors.blue500],
              begin: pw.Alignment.topLeft,
              end: pw.Alignment.bottomRight)),
      child: pw.Center(
          child: pw.Text('-Invoice-',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 30,
              ))));
}

pw.Padding imageFromInput(
    pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
    Uint8List imageBytes) {
  return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: pw.FittedBox(
          child: pw.Image(pdfImageProvider(imageBytes), width: 3),
          fit: pw.BoxFit.fitHeight,
          alignment: pw.Alignment.center));
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 15, color: PdfColors.blue)));
