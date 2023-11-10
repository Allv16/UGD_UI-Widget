import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd_ui_widget/View/profileEdit.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'home.dart';
import 'my_reservation.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String username = '';
  String email = '';
  String noTelp = '';
  String tglLahir = '';
  String profilePath = '';
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      noTelp = prefs.getString('noTelp')!;
      tglLahir = prefs.getString('tglLahir')!;
      profilePath = prefs.getString('profilePath')!;
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
      body: Padding(
        padding: const EdgeInsets.only(top: 64, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(children: [
                  SizedBox(
                    width: 86,
                    height: 86,
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
                          _displayBottomSheet();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.primary),
                          child: const Icon(Icons.edit,
                              color: Colors.white, size: 15),
                        ),
                      ))
                ]),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                          softWrap: true),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.black54,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(email),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.black54,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(noTelp),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(tglLahir),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Account Settings',
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text(
                'Edit Profile',
                textAlign: TextAlign.left,
              ),
              contentPadding: const EdgeInsets.all(0),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 15, color: Colors.grey),
              horizontalTitleGap: 0,
              shape: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 1)),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEditView(),
                  ),
                ).then((_) => loadUserData())
              },
            ),
            ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text(
                  'Logout',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.red),
                ),
                contentPadding: const EdgeInsets.all(0),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    size: 15, color: Colors.grey),
                horizontalTitleGap: 0,
                shape: const Border(bottom: BorderSide(color: Colors.grey)),
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      )
                    }),
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

  Future _displayBottomSheet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              child: Column(
                children: [
                  Text(
                    "Select Image Source",
                    style: TextStyle(
                        fontSize: 20, color: Color(Colors.grey[900]!.value)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: IconButton(
                                    iconSize: 40,
                                    icon: Icon(
                                      Icons.photo,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      _pickImageFromGallery().then(
                                          (value) => Navigator.pop(context));
                                    },
                                  )),
                            ),
                            const Text("Gallery")
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                    iconSize: 40,
                                    icon: const Icon(Icons.camera_alt,
                                        color: Colors.black),
                                    onPressed: () {
                                      _pickImageFromCamera().then(
                                          (value) => Navigator.pop(context));
                                    },
                                  )),
                            ),
                            const Text("Camera")
                          ],
                        )
                      ]),
                ],
              ),
            ));
  }

  Future _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await SQLHelperUser.editProfile(pickedFile.path, email);
        prefs.setString('profilePath', pickedFile.path);
        setState(() {
          profilePath = pickedFile.path;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  Future _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await SQLHelperUser.editProfile(pickedFile.path, email);
        prefs.setString('profilePath', pickedFile.path);
        setState(() {
          profilePath = pickedFile.path;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
