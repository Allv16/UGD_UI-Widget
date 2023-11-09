import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/edit_photo.dart';
import 'package:ugd_ui_widget/View/profileEdit.dart';
import 'home.dart';
import 'my_reservation.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/camera.dart';
import 'package:ugd_ui_widget/View/edit_photo.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: profilePath.isEmpty
                        ? Image.asset(
                            'images/kucheng.jpeg',
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(profilePath),
                            width: 160,
                            height: 160,
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
                                  editPhoto())); // ganti disini buat arahin ke camera view
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.primary),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 20),
                    ),
                  ))
            ]),
            SizedBox(height: 20),
            TextFormField(
              controller: usernameController,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
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
                  fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
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
                  fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
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
                  fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.calendar_today,
                    color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24, right: 15, left: 15),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(360, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
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
