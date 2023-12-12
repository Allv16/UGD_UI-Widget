import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/doctor_list.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_reservation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shake/shake.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final carouselContent = [
    "Engaging in laughter doesn't just uplift your mood; it also has immune-boosting effects.",
    "Blueberries are packed with antioxidants, particularly anthocyanins, which have been linked to improved cognitive function.",
    "Quality sleep is crucial for overall health. During sleep, the body repairs cells and tissues, consolidates memories.",
    "Staying properly hydrated not only supports bodily functions but also has a direct impact on cognitive performance. ",
    "Regular walking is a simple yet effective way to maintain cardiovascular health. Aim for at least 30 minutes of brisk walking most days of the week.",
    "Incorporating mindfulness meditation into your routine has been shown to reduce stress and improve mental well-being.",
    "Maintaining strong social connections is associated with a longer and healthier life. "
  ];

  String username1 = "";
  String profilePath = '';
  String bpjsNumber = '';
  late ShakeDetector detector;

  Future<Image> getImage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    var image = Image.network(
      "http://52.185.188.129:8000/profiles/$profilePath?${DateTime.now().millisecondsSinceEpoch.toString()}",
      headers: const {
        HttpHeaders.connectionHeader: "keep-alive",
        HttpHeaders.cacheControlHeader: "max-age=0",
      },
    );
    return image;
  }

  void initState() {
    loadUserData();
    super.initState();

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
    String? bpjs = prefs.getString('bpjs');
    setState(() {
      username1 = username!;
      profilePath = newPath!;
      bpjsNumber = bpjs!;
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
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget menuBox(String gambar, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorList(
              poly: text,
              bpjsNumber: bpjsNumber,
            ),
          ),
        );
      },
      child: Material(
        color: Colors.white,
        elevation: 15.0,
        borderRadius: BorderRadius.circular(24.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        gambar,
                        width: 90,
                        height: 90,
                      )),
                  Text(text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ))
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
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.waiting ||
                                              snapshot.data == null) {
                                            return const CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.data == null) {
                                            return const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'images/kucheng.jpeg'));
                                          } else {
                                            return CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.grey[100],
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
                  SizedBox(
                    height: 3.h,
                  ),
                  CarouselSlider.builder(
                      itemCount: carouselContent.length,
                      options: CarouselOptions(
                          height: 25.h, autoPlay: true, viewportFraction: 1),
                      itemBuilder: (context, index, realIndex) {
                        return healthFactItem(carouselContent[index]);
                      }),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("What do you need?",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      )),
                  const Text(
                      "Make your reservation now by choosing the menu below",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey)),
                  SizedBox(
                    height: 3.h,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: gridCount,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: [
                      menuBox(
                        "images/poly/DentalCare.png",
                        "Dentist",
                      ),
                      menuBox(
                        "images/poly/orthopedics(2).png",
                        "Orthopedic",
                      ),
                      menuBox(
                        "images/poly/pediatrics.png",
                        "Pediatric",
                      ),
                      menuBox(
                        "images/poly/Pulmonologist.png",
                        "Pulmonology",
                      ),
                      menuBox("images/poly/PlasticSurgery.png", "Dermatology"),
                      menuBox("images/poly/ENT.png", "ENT"),
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

  Widget healthFactItem(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Health Fact",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              overflow: TextOverflow.fade),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey[200], fontSize: 15),
        )
      ]),
    );
  }
}
