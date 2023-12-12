import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';
import 'package:ugd_ui_widget/View/payment/payment.dart';
import 'package:ugd_ui_widget/client/reservationClient.dart';

class bookingSuccessPage extends StatefulWidget {
  const bookingSuccessPage(
    {Key? key,
    required bool this.has_bpjs,
    required String this.doctor_name,
    required String this.reservation_date,
    required String this.jam_praktek,
    required int this.id_payment,
    }) : super(key: key);

  final bool has_bpjs;
  final String doctor_name;
  final String reservation_date;
  final String jam_praktek;
  final int id_payment;

  @override
  _bookingSuccessPageState createState() => _bookingSuccessPageState();
}

class _bookingSuccessPageState extends State<bookingSuccessPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'images/Check.png',
                  height: 100, // Set the height to make the image smaller
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Thanks For Booking! ',
                      style: GoogleFonts.raleway(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "You booked an appointment with ${widget.doctor_name} on ${formatDate(widget.reservation_date)} at ${widget.jam_praktek} - ${addOneHour(widget.jam_praktek)}",
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 320, // Set the desired width for the button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15.0,
                      ),
                    ),
                    onPressed:  () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return PaymentView(
                            id_payment: widget.id_payment,
                          );
                        }),
                      );
                    },
                    child: const Text(
                      'PAY NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Don't want to pay right now?",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeView();
                    }));
                  },
                  child: Text(
                    "Pay Later",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

String formatDate(String date) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final inputDate = inputFormat.parse(date);

  final outputFormat = DateFormat('EEEE, MMM d');
  return outputFormat.format(inputDate);
}


String addOneHour(String time) {
  final timeFormat = DateFormat('HH:mm');
  DateTime dateTime = timeFormat.parse(time);
  dateTime = dateTime.add(const Duration(hours: 1));
  return timeFormat.format(dateTime);
}