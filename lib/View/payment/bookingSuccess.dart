import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';
import 'package:ugd_ui_widget/View/payment/payment.dart';

class bookingSuccessPage extends StatefulWidget {
  const bookingSuccessPage(
    {Key? key,
    required bool this.has_bpjs,
    required String this.doctor_name,
    required DateTime this.reservation_date,
    required String this.jam_praktek,
    }) : super(key: key);

  final bool has_bpjs;
  final String doctor_name;
  final DateTime reservation_date;
  final String jam_praktek;

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
                        "You booked an appointment with ${widget.doctor_name} on ${formatDateTime(widget.reservation_date)} at ${widget.jam_praktek} - ${addOneHour(widget.jam_praktek)}",
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
                    onPressed: () {
                      // Handle button click
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const PaymentView();
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[600],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyReservation(),
          ),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileView(),
          ),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => bookingSuccessPage(has_bpjs: true,doctor_name: "Alvian" ,reservation_date: DateTime.now() ,jam_praktek: "17:00" ),
          ),
        );
      }
    });
  }
}

String formatDateTime(DateTime dateTime) {
  final outputFormat = DateFormat('EEEE, d MMMM y');
  return outputFormat.format(dateTime);
}


String addOneHour(String time) {
  final timeFormat = DateFormat('HH:mm');
  DateTime dateTime = timeFormat.parse(time);
  dateTime = dateTime.add(const Duration(hours: 1));
  return timeFormat.format(dateTime);
}