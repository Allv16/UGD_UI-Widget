import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/View/payment/bookingSuccess.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_reservation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shake/shake.dart';
import 'package:ugd_ui_widget/constant/app_constant.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String username1 = "";
  String profilePath = '';
  late ShakeDetector detector;
  Future<Image> getImage() async {
    var image = Image.network(
      "http://52.185.188.129:8000/profiles/$profilePath",
      headers: const {
        HttpHeaders.connectionHeader: "keep-alive",
        HttpHeaders.cacheControlHeader: "max-age=0",
      },
    );
    return image;
  }

  void initState() {
    super.initState();
    loadUserData();

    detector = ShakeDetector.autoStart(onPhoneShake: () async {
      final Uri url = Uri(
        scheme: 'tel',
        path: '911',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print('cannot launch this url');
      }
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? newPath = prefs.getString('profilePath');
    setState(() {
      username1 = username!;
      profilePath = newPath!;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      _selectedIndex = 1;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new MyReservation(),
        ),
      );
    } else if (index == 2) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(),
        ),
      );
    }else if (index == 3) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bookingSuccessPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Material menuBox(String gambar, String text, int color) {
    return Material(
      color: Colors.white,
      elevation: 15.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          gambar,
                          width: 45,
                          height: 45,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,
                          style: TextStyle(
                            color: Color(color),
                            fontSize: 15.0,
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(builder: (context, orientation) {
        int gridCount = (orientation == Orientation.portrait) ? 3 : 5;
        return SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hello,",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            Text(
                              username1.isEmpty
                                  ? ''
                                  : username1[0].toUpperCase() +
                                      username1.substring(1),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileView(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                profilePath == '-1'
                                    ? const CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage('images/kucheng.jpeg'),
                                      )
                                    : FutureBuilder(
                                        future: getImage(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircleAvatar(),
                                            );
                                          } else if (snapshot.data == null) {
                                            return const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'images/kucheng.jpeg'));
                                          } else {
                                            return CircleAvatar(
                                              radius: 50,
                                              backgroundImage: snapshot
                                                  .data!.image as ImageProvider,
                                            );
                                          }
                                        })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                        color: Colors.cyan[600],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Health Fact",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Dalam istilah Kedokteran, istilah penyakit panas dalam tidak pernah ada.",
                            style: TextStyle(
                                color: Colors.grey[200], fontSize: 20),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "What do you need?",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF00ACC1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: gridCount,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: [
                      menuBox("images/medicine.png", "Medecine", 0xFF00ACC1),
                      menuBox("images/medicine.png", "Diagnostic", 0xFF00ACC1),
                      menuBox(
                          "images/medicine.png", "Consultation", 0xFF00ACC1),
                      menuBox("images/medicine.png", "Ambulance", 0xFF00ACC1),
                      menuBox("images/medicine.png", "Nurse", 0xFF00ACC1),
                      menuBox("images/medicine.png", "First Aid", 0xFF00ACC1),
                      menuBox("images/medicine.png", "First Aid", 0xFF00ACC1),
                      menuBox("images/medicine.png", "First Aid", 0xFF00ACC1),
                      menuBox("images/medicine.png", "First Aid", 0xFF00ACC1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'payment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
