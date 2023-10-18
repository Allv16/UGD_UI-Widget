import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                DatePicker(
                    validasi: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Pilih tanggal lahir!";
                      }
                      return null;
                    }),
                    controller: tglLahirController,
                    hintTxt: "Tanggal Lahir",
                    helperTxt: "ex: 2022-06-12",
                    iconData: Icons.calendar_today),
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
                InputForm(
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
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formData = {};
                        formData['username'] = usernameController.text;
                        formData['password'] = passwordController.text;
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text("Register Success!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => LoginView(
                                                      data: formData,
                                                    ))),
                                        child: Text("OK"))
                                  ],
                                ));
                      }
                    },
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
