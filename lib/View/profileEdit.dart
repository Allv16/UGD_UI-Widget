import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/client/userClient.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/model/user.dart';

class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailUser = "";
  bool _isLoading = false;

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? noTelp = prefs.getString('noTelp');
    String? tglLahir = prefs.getString('tglLahir');
    String? password = prefs.getString('password');

    setState(() {
      usernameController.text = username ?? '';
      notelpController.text = noTelp != null ? noTelp.toString() : '';
      tglLahirController.text = tglLahir!;
      passwordController.text = password!;
      emailUser = email!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(1.h),
              child: Column(
                children: [
                  InputForm(
                      key: const Key('usernameField'),
                      validasi: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Username Tidak Boleh Kosong';
                        }
                        if (p0.toLowerCase() == 'anjing') {
                          return 'Tidak Boleh mengginakan kata kasar';
                        }
                        return null;
                      },
                      controller: usernameController,
                      hintTxt: "Username",
                      helperTxt: "ex: JohnDoe",
                      iconData: Icons.person),
                  SizedBox(
                    height: 2.h,
                  ),
                  InputForm(
                      key: const Key('passwordField'),
                      validasi: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password kosong';
                        }
                        if (value.length < 5) {
                          return 'password must be 5 or more characters';
                        }
                        return null;
                      },
                      password: true,
                      controller: passwordController,
                      hintTxt: "Password",
                      helperTxt: "must use 5 or more character",
                      iconData: Icons.password),
                  SizedBox(
                    height: 2.h,
                  ),
                  InputForm(
                      key: const Key('telpField'),
                      validasi: ((p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong';
                        }
                        if (p0.length < 11) {
                          return 'Nomor Telepon harus lebih dari 11 digit';
                        }
                        return null;
                      }),
                      controller: notelpController,
                      hintTxt: "No Telp",
                      helperTxt: "ex: 085154433118",
                      iconData: Icons.phone_android),
                  SizedBox(
                    height: 2.h,
                  ),
                  DatePicker(
                    key: const Key('tglLahirField'),
                    validasi: ((String? selectedDate) {
                      if (selectedDate == null || selectedDate.isEmpty) {
                        return "Select birth date";
                      }
                      return null;
                    }),
                    controller: tglLahirController,
                    hintTxt: "Birth date",
                    helperTxt: "ex: 05 Dec 2001",
                    iconData: Icons.calendar_today,
                    selectedDate: tglLahirController.text,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(100.w, 6.h)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        await saveEditedData();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView()));
                      }
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveEditedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = usernameController.text;
    final noTelp = notelpController.text;
    DateTime parsedDate = DateTime.parse(tglLahirController.text);
    final tanggalLahir = DateFormat('yyyy-MM-dd').format(parsedDate);
    final password = passwordController.text;

    try {
      // // Save data yang udh diedit di shared pref (update lah)
      prefs.setString('username', username);
      prefs.setString('noTelp', noTelp);
      prefs.setString('password', password);
      prefs.setString('tglLahir', tanggalLahir);

      // Update data ke API
      User user = User(
          username: username,
          email: emailUser,
          noTelp: noTelp,
          tglLahir: tanggalLahir,
          password: password,
          profilePath: '-1',
          bpjs: '-1');
      await UserClient.updateProfile(user);

      // Pop the current screen and return to the previous screen
      Navigator.pop(context, true);
    } catch (e) {
      print('Error during navigation: $e');
    }
  }
}
