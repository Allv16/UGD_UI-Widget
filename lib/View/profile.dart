import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd_ui_widget/View/profileEdit.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'home.dart';
import 'my_reservation.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      body: OrientationBuilder(builder: (context, orientation) {
        bool isPortrait = orientation == Orientation.portrait;
        return Padding(
          padding: EdgeInsets.only(top: 6.h, left: 2.h, right: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(children: [
                    SizedBox(
                      width: 19.w,
                      height: 11.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: profilePath.isEmpty
                              ? Image.asset(
                                  'images/kucheng.jpeg',
                                  width: 38.w,
                                  height: 18.px,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(profilePath),
                                  width: 38.w,
                                  height: 18.px,
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
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.primary),
                            child: Icon(Icons.edit,
                                color: Colors.white, size: 15.sp),
                          ),
                        ))
                  ]),
                  SizedBox(
                    width: 3.w,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                            softWrap: true),
                        SizedBox(
                          height: 4.px,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.black54,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(email),
                          ],
                        ),
                        SizedBox(
                          height: 4.px,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black54,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(noTelp),
                          ],
                        ),
                        SizedBox(
                          height: 4.px,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.black54,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(tglLahir),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text('Account Settings',
                  style: GoogleFonts.lato(
                      fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: const Text(
                  'Edit Profile',
                  textAlign: TextAlign.left,
                ),
                contentPadding: const EdgeInsets.all(0),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    size: 16.sp, color: Colors.grey),
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
                  trailing: Icon(Icons.arrow_forward_ios_rounded,
                      size: 16.sp, color: Colors.grey),
                  horizontalTitleGap: 0,
                  shape: const Border(bottom: BorderSide(color: Colors.grey)),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        )
                      }),
            ],
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
              padding: EdgeInsets.all(20.sp),
              height: 24.h,
              child: Column(
                children: [
                  Text(
                    "Select Image Source",
                    style: TextStyle(
                        fontSize: 19.sp, color: Color(Colors.grey[500]!.value)),
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
                                  padding: EdgeInsets.all(10.sp),
                                  child: IconButton(
                                    iconSize: 25.sp,
                                    icon: const Icon(
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
                                  padding: EdgeInsets.all(10.sp),
                                  child: IconButton(
                                    iconSize: 25.sp,
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
