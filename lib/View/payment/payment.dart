import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/View/payment/detail/bca.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd_ui_widget/View/payment/detail/bni.dart';
import 'package:ugd_ui_widget/View/payment/detail/bri.dart';
import 'package:ugd_ui_widget/View/payment/detail/cimbNiaga.dart';
import 'package:ugd_ui_widget/View/payment/detail/dana.dart';
import 'package:ugd_ui_widget/View/payment/detail/gopay.dart';
import 'package:ugd_ui_widget/View/payment/detail/linkaja.dart';
import 'package:ugd_ui_widget/View/payment/detail/ovo.dart';
import 'package:ugd_ui_widget/View/payment/detail/shopee.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      _selectedIndex = 0;
      // Handle navigation to the DetailView or another desired screen
    } else if (index == 2) {
      _selectedIndex = 2;
      // Handle navigation to the ProfileView or another desired screen
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

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
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => bcaView()),
                      );
                    },
                  ),
                  menuBox(
                    "images/bni.png",
                    "BNI",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => bniView()),
                      );
                    },
                  ),
                  menuBox(
                    "images/bri.png",
                    "BRI",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => briView()),
                      );
                    },
                  ),
                  menuBox(
                    "images/cimb.png",
                    "CIMB NIAGA",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cimbNiagaView()),
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
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => shopeeView()),
                      );
                    },
                  ),
                  menuBox2(
                    "images/gopay.png",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => gopayView()),
                      );
                    },
                  ),
                  menuBox2(
                    "images/dana.png",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => danaView()),
                      );
                    },
                  ),
                  menuBox2(
                    "images/linkaja.png",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => linkajaView()),
                      );
                    },
                  ),
                  menuBox2(
                    "images/ovo.png",
                    0xFF00ACC1,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ovoView()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
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
        selectedItemColor: Colors.cyan[600],
        onTap: _onItemTapped,
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
