import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/View/home.dart';
import 'package:ugd_ui_widget/View/register.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "login",
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
                        return 'username tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Input Username",
                    iconData: Icons.person,
                  ),
                  SizedBox(
                    height: 10,
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
                      helperTxt: "Minimal 5 digit password",
                      iconData: Icons.password),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // tombol login
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (dataForm!['username'] ==
                                      usernameController.text &&
                                  dataForm['password'] ==
                                      passwordController.text) {
                                showToastMessage("Login Successful");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeView()));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Password Salah'),
                                    content: TextButton(
                                      onPressed: () => pushRegister(context),
                                      child: const Text('Daftar Disini !!'),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('login')),

                      TextButton(
                          onPressed: () {
                            Map<String, dynamic> formData = {};
                            formData['username'] = usernameController.text;
                            formData['password'] = passwordController.text;
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
        builder: (_) => const RegisterView(),
      ),
    );
  }
}

void showToastMessage(msg) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.grey[200],
      fontSize: 15.0,
    );