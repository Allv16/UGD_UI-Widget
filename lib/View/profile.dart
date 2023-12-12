import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/bpjs_form.dart';
import 'package:ugd_ui_widget/View/payment_history.dart';
import 'package:ugd_ui_widget/View/profileEdit.dart';
import 'home.dart';
import 'my_reservation.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/client/userClient.dart';
import 'package:ugd_ui_widget/utils/custom_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  String bpjs = '';
  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  Future<Image> getImage() async {
    String cacheScrewer = DateTime.now().millisecondsSinceEpoch.toString();
    await Future.delayed(const Duration(milliseconds: 500));
    var image = Image.network(
      "http://52.185.188.129:8000/profiles/$profilePath?$cacheScrewer",
      headers: const {
        HttpHeaders.connectionHeader: "keep-alive",
        HttpHeaders.cacheControlHeader: "max-age=0",
      },
    );
    return image;
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      noTelp = prefs.getString('noTelp')!;
      DateTime parsedDate = DateTime.parse(prefs.getString('tglLahir')!);
      tglLahir = DateFormat('dd MMM yyyy').format(parsedDate);
      profilePath = prefs.getString('profilePath') ?? '-1';
      bpjs = prefs.getString('bpjs')!;
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
        return Padding(
          padding: EdgeInsets.only(top: 6.h, left: 2.h, right: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  profilePath == '-1'
                      ? Stack(children: [
                          const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/kucheng.jpeg')),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  child: Icon(Icons.edit,
                                      color: Colors.white, size: 15.sp),
                                ),
                              ))
                        ])
                      : FutureBuilder(
                          future: getImage(),
                          initialData: null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.data == null) {
                              return const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data == null) {
                              return const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('images/kucheng.jpeg'));
                            } else {
                              return Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        snapshot.data!.image as ImageProvider,
                                    backgroundColor: Colors.grey[100],
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
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: Icon(Icons.edit,
                                              color: Colors.white, size: 15.sp),
                                        ),
                                      ))
                                ],
                              );
                            }
                          }),
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
                          height: 2.px,
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
                          height: 2.px,
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
                            Text(CustomeFormatter.phoneNumberFormat(noTelp)),
                          ],
                        ),
                        SizedBox(
                          height: 2.px,
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
              Text('Transaction',
                  style: GoogleFonts.lato(
                      fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ListTile(
                leading: const Icon(FontAwesomeIcons.receipt, size: 20),
                title: const Text(
                  'Payment History',
                  textAlign: TextAlign.left,
                ),
                contentPadding: const EdgeInsets.all(0),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    size: 16.sp, color: Colors.grey),
                horizontalTitleGap: 11,
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentHistoryPage(),
                    ),
                  ).then((_) => loadUserData())
                },
              ),
              SizedBox(
                height: 2.h,
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
                horizontalTitleGap: 11,
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
                leading: const FaIcon(
                  FontAwesomeIcons.idCard,
                  size: 20,
                ),
                title: Text(
                  "Manage BPJS",
                  textAlign: TextAlign.left,
                ),
                contentPadding: const EdgeInsets.all(0),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    size: 16.sp, color: Colors.grey),
                horizontalTitleGap: 10,
                shape: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 1)),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BPJSForm(
                        bpjs: bpjs,
                        email: email,
                        username: username,
                      ),
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
                  horizontalTitleGap: 11,
                  shape: const Border(bottom: BorderSide(color: Colors.grey)),
                  onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (route) => false,
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
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String newPath =
            await UserClient.updateProfilePicture(email, pickedFile);
        prefs.setString('profilePath', newPath);
        setState(() {
          profilePath = newPath;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  Future _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedFile != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String newPath =
            await UserClient.updateProfilePicture(email, pickedFile);

        prefs.setString('profilePath', newPath);
        setState(() {
          profilePath = newPath;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
