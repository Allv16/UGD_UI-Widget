import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profileEdit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

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

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      noTelpController.text = noTelp != null ? noTelp.toString() : '';
    });
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
            ClipOval(// untuk mengatur bentuk gambar jd bulat
              child: Image.asset(
                'images/stel.jpg',
                width: 200, 
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20), 
            TextFormField(
              controller: usernameController,
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: emailController,
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: noTelpController,
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 30, 127, 207)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android, color: const Color.fromARGB(255, 50, 50, 50)),
              ),
              enabled: false,
            ),
          ],
        ),
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
