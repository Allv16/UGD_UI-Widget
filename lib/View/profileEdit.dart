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
  String emailUser = "";

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? noTelp = prefs.getString('noTelp');
    String? tglLahir = prefs.getString('tglLahir');

    setState(() {
      usernameController.text = username ?? '';
      notelpController.text = noTelp != null ? noTelp.toString() : '';
      tglLahirController.text = tglLahir!;
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
              MaterialPageRoute(builder: (context) => ProfileView()),
            );
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
    final noTelp = notelpController.text;

    try {
      // // Save data yang udh diedit di shared pref (update lah)
      prefs.setString('username', username);
      prefs.setString('noTelp', noTelp);

      // Update data ke sql
      await SQLHelperUser.editUser(username, emailUser, noTelp);

      // Pop the current screen and return to the previous screen
      Navigator.pop(context, true);
    } catch (e) {
      print('Error during navigation: $e');
    }
  }
}
