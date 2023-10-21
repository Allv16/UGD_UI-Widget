import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/component/form_component.dart';


class ProfileEditView extends StatefulWidget {
  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? noTelp = prefs.getString('noTelp');
    String? tglLahir = prefs.getString('tglLahir');

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      notelpController.text = noTelp != null ? noTelp.toString() : '';
      tglLahirController.text = tglLahir ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputForm(
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
            InputForm(
              validasi: ((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Nomor Telepon tidak boleh kosong';
                }

                return null;
              }),
              controller: notelpController,
              hintTxt: "No Telp",
              helperTxt: "ex: 085154433118",
              iconData: Icons.phone_android),
          InputForm(
              validasi: ((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                if (!p0.contains('@')) {
                  return 'Email harus menggunakan @';
                }
                return null;
              }),
              controller: emailController,
              hintTxt: "Email",
              helperTxt: "ex: john@hospital.com",
              iconData: Icons.email),
             DatePicker(
              validasi: ((value) {
                if (value == null || value.isEmpty) {
                  return "Pilih tanggal lahir!";
                }
                return null;
              }),
              controller: tglLahirController,
              hintTxt: "Tanggal Lahir",
              helperTxt: "",
              iconData: Icons.calendar_today),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            saveEditedData();
            Navigator.pop(context, true);
            final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),);
          } catch (e) {
            print('Error: $e');
          }
        },
  child: Icon(Icons.save),
),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> saveEditedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = usernameController.text;
    final email = emailController.text;
    final noTelp = notelpController.text;
    final tglLahir = tglLahirController.text;
    
    try {
    // // Save data yang udh diedit di shared pref (update lah)
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('noTelp', noTelp);
    prefs.setString('tglLahir', tglLahir);

    // Update data ke sql
    final db = await SQLHelperUser.editUser(username, email, noTelp, tglLahir);

    // Pop the current screen and return to the previous screen
    Navigator.pop(context, true);
  } catch (e) {
    print('Error during navigation: $e');
  }
  }
}
