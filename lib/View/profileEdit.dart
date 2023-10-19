import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


    // print('Username: $username');
    // print('Email: $email');
    // print('No. Telp: $noTelp');
    // print('Tanggal Lahir: $tglLahir');

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
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: notelpController,
              decoration: InputDecoration(
                labelText: 'No. Telp',
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            TextFormField(
              controller: tglLahirController,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveEditedData();
          Navigator.pop(context, true);
        },
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> saveEditedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id;
    final username = usernameController.text;
    final email = emailController.text;
    final noTelp = notelpController.text;
    final tglLahir = tglLahirController.text;

    // Savedata yang udh diedit
    await prefs.setInt('id',0);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('noTelp', noTelp);
    await prefs.setString('tglLahir', tglLahir);

    // Update data ke sql
   // final db = await SQLHelperUser.editUser(id, username, email, noTelp, tglLahir);

    Navigator.pop(context, true);
  }
}
