import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:ugd_ui_widget/View/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  int userID = -1;
  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    final data = await SQLHelperUser.getUser();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 40,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 100,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputForm(
                    validasi: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "",
                    iconData: Icons.email,
                  ),
                  InputForm(
                      validasi: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password kosong';
                        }
                        return null;
                      },
                      password: true,
                      controller: passwordController,
                      hintTxt: "Password",
                      helperTxt: "",
                      iconData: Icons.password),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // tombol login
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = emailController.text;
                            String password = passwordController.text;
                            Map<dynamic, dynamic> loginResult =
                                await SQLHelperUser.loginUser(email, password);
                            print(loginResult['id']);
                            if (loginResult['id'] != -1) {
                              //set sharedpreferenced
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'username', loginResult['username']);
                              prefs.setString('email', loginResult['email']);
                              prefs.setString('noTelp', loginResult['noTelp']);
                              prefs.setString(
                                  'password', loginResult['password']);
                              prefs.setString(
                                  'tglLahir', loginResult['tglLahir']);

                              showToastMessage(
                                  "Login Successful", Colors.green);

                              // Continue to the home page or another screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeView(),
                                ),
                              );
                            } else {
                              // Login failed
                              showToastMessage("Login Failed", Colors.red);
                            }
                          }
                        },
                        child: const Text('login'),
                      ),

                      TextButton(
                          onPressed: () {
                            pushRegister(context);
                          },
                          child: const Text("Belum punya akun ?")),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterView(
          title: 'REGISTER USER',
          id: null,
          username: null,
          email: null,
          password: null,
          tglLahir: null,
          notelp: null,
        ),
      ),
    );
  }
}

void showToastMessage(msg, color) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.grey[200],
      fontSize: 15.0,
    );
