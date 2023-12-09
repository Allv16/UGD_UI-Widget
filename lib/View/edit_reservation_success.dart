import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:uuid/uuid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'home.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditReservationSuccess extends StatefulWidget {
  final String doctorName;
  final String date;
  final String time;

  const EditReservationSuccess({
    Key? key,
    required this.doctorName,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  _EditReservationSuccessState createState() => _EditReservationSuccessState();
}

class _EditReservationSuccessState extends State<EditReservationSuccess> {
  int _selectedIndex = 1; // Untuk mengontrol item terpilih pada BottomNavigationBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(), // Ganti Home() dengan widget untuk halaman Home Anda
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(), // Ganti Profile() dengan widget untuk halaman Profile Anda
        ),
      );
    }
    // Jika index == 1 (atau yang lainnya), biarkan seperti itu sesuai dengan tindakan yang diinginkan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 40, 111, 169),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Edit Reservation Success',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 21.0),
            Text(
              'You booked appointment with\nDr. ${widget.doctorName}\non ${widget.date} at ${widget.time}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 42.0),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // actionnnnnnnn......
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: Size(double.infinity, 50.0),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyReservation()), 
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Don\'t want to pay right now? ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black, 
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nPAY LATER',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Ganti warna sesuai preferensi Anda
        onTap: _onItemTapped,
      ),
    );
  }
}