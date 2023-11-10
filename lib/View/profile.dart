import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/profileEdit.dart';
import 'home.dart';
import 'my_reservation.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/camera.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  String profilePath = '';
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? noTelp = prefs.getString('noTelp');
    String? tgl = prefs.getString('tglLahir');
    String? newPath = prefs.getString('profilePath');

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      noTelpController.text = noTelp != null ? noTelp.toString() : '';
      tglLahirController.text = tgl ?? '';
      profilePath = newPath!;
    });
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 1) {
      _selectedIndex = 1;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new MyReservation(),
        ),
      );
    } else if (index == 0) {
      _selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
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
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              SizedBox(
                width: 160.px,
                height: 160.px,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.px),
                    child: profilePath.isEmpty
                        ? Image.asset(
                            'images/pp.jpg',
                            width: 40.px,
                            height: 40.px,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(profilePath),
                            width: 40.px,
                            height: 40.px,
                            fit: BoxFit.cover,
                          )),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CameraView())); // ganti disini buat arahin ke camera view
                    },
                    child: Container(
                      width: 50.px,
                      height: 50.px,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.px),
                          color: Theme.of(context).colorScheme.primary),
                      child: Icon(Icons.camera_alt,
                          color: Colors.white, size: 24.px),
                    ),
                  ))
            ]),
            SizedBox(height: 3.h),
            TextFormField(
              controller: usernameController,
              style: TextStyle(
                  fontSize: 18.sp, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.person,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: emailController,
              style: TextStyle(
                  fontSize: 18.sp, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.email,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: noTelpController,
              style: TextStyle(
                  fontSize: 18.sp, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                labelText: 'No. Telp',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.phone_android,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: tglLahirController,
              style: TextStyle(
                  fontSize: 18.sp, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.calendar_today,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h,bottom: 2.h, right: 2.w, left: 2.w),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size(80.w, 7.h)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileEditView()),
          );
          if (result != null && result) {
            loadUserData();
          }
        },
        child: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
