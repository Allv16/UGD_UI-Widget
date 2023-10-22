import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'package:ugd_ui_widget/model/user.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.id,
    required this.title,
    required this.username,
    required this.email,
    required this.password,
    required this.notelp,
    required this.tglLahir,
  });

  final String? email, username, title, password, tglLahir, notelp;
  final int? id;

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
    if (widget.id != null) {
      usernameController.text = widget.username!;
      emailController.text = widget.email!;
      passwordController.text = widget.password!;
      notelpController.text = widget.notelp!;
      tglLahirController.text = widget.tglLahir!;
    }
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
                  validasi: ((String? selectedDate) {
                    DateTime now = DateTime.now();
                    if (selectedDate == null || selectedDate.isEmpty) {
                      return "Pilih tanggal lahir!";
                    }
                    DateTime? selectedDateTime =
                        DateTime.tryParse(selectedDate);
                    if (selectedDateTime?.isAfter(now) ?? false) {
                      return 'Tanggal yang dimasukkan tidak boleh lebih dari sekarang';
                    }
                    return null;
                  }),
                  controller: tglLahirController,
                  hintTxt: "Tanggal Lahir",
                  helperTxt: "ex: 2022-06-12",
                  iconData: Icons.calendar_today,
                  selectedDate: null,
                ),
                InputForm(
                    validasi: ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Nomor Telepon tidak boleh kosong';
                      }
                      if (p0.length < 11) {
                        return 'Nomor telepon harus memiliki setidaknya 11 digit!';
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (await SQLHelperUser.isEmailUnique(
                                emailController.text) ==
                            true) {
                          await addUser();
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Register Success!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => LoginView(),
                                                ),
                                              ),
                                          child: Text("OK"))
                                    ],
                                  ));
                        } else {
                          showToastMessage(
                              "Tidak bisa register email tidak unik",
                              Colors.red);
                        }
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

  Future<void> addUser() async {
    await SQLHelperUser.addUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
        notelpController.text,
        tglLahirController.text);
  }

  Future<void> editUser(int id) async {
    await SQLHelperUser.editUser(id, usernameController.text,
        emailController.text, notelpController.text, tglLahirController.text);
  }
}
