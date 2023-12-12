import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd_ui_widget/View/payment/transfer.dart';
import 'package:ugd_ui_widget/client/reservationClient.dart';

class PaymentView extends StatefulWidget {
  final String? image_path;
  // final String? jenis_pembayaran;
  final int id_payment;

  const PaymentView({Key? key, 
  this.image_path,
  required this.id_payment}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
String? jenis_Pembayaran;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Payment Method',
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body:
        Card(
        elevation: 5.0,
        margin: EdgeInsets.all(16.0), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "BANK TRANSFER",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: [
                  menuBox(
                    "images/bca.png",
                    "BCA",
                    0xFF00ACC1,
                    () async {
                      print("BCA");
                      jenis_Pembayaran = "BCA";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/bca.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox(
                    "images/bni.png",
                    "BNI",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "BNI";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/bni.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox(
                    "images/bri.png",
                    "BRI",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "BRI";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/bri.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox(
                    "images/cimb.png",
                    "CIMB NIAGA",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "CIMB NIAGA";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/cimb.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
                color: Colors.black38,
                indent: 3,
                endIndent: 3,
              ),
              SizedBox(height: 10),
              Text(
                "OTHER E-WALLET",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: [
                  menuBox2(
                    "images/shopee.png",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "Shopee";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/shopee.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox2(
                    "images/gopay.png",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "GOPAY";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/gopay.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox2(
                    "images/dana.png",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "DANA";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/dana.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox2(
                    "images/linkaja.png",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "LinkAja";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/linkaja.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                  menuBox2(
                    "images/ovo.png",
                    0xFF00ACC1,
                    () async {
                      jenis_Pembayaran = "OVO";
                      await ReservationClient.updateJenisPembayaran(
                            widget.id_payment,
                            jenis_Pembayaran!,
                            "Pending"
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return transferView(
                            image_path: "images/ovo.png",
                            id_payment: widget.id_payment,
                          );
                          }),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget menuBox(String imagePath, String title, int color, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBox2(String imagePath, int color, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 80.0,
        width: 120.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
