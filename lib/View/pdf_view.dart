import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/preview_screen.dart';

Future<void> createPdf(
    String id, String doctor, String date, BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final pdfTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (pw.Context context) {
        return pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(
          color: PdfColors.blue100,
          width: 50,
        )));
      });

  doc.addPage(pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("ID Reservation: $id",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                    )),
                pw.Text("Doctor: $doctor",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                    )),
                pw.Text("Date: $date",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                    )),
                pw.Container(
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
              ])
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex("#FFBD59"),
            child: footerPDF(formattedDate));
      }));
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)));
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
