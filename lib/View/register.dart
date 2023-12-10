import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/client/userClient.dart';
import 'package:ugd_ui_widget/model/user.dart';
import 'package:ugd_ui_widget/View/login.dart';

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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color(0xFF1B90B8),
            Color.fromARGB(221, 27, 145, 184),
            Color.fromARGB(162, 27, 145, 184),
          ])),
          child: Column(
            children: [
              Center(
                child: DropShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 25),
                    color: Colors.black.withOpacity(0.4),
                    child: Image.asset(
                      'images/register.png',
                      height: 300,
                    )),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Create New Account',
                              style: GoogleFonts.raleway(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            InputForm(
                                key: Key('usernameField'),
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
                                key: Key('dateField'),
                                validasi: ((String? selectedDate) {
                                  DateTime now = DateTime.now();
                                  if (selectedDate == null ||
                                      selectedDate.isEmpty) {
                                    return "Pilih tanggal lahir!";
                                  }
                                  DateFormat inputFormat =
                                      DateFormat('yyyy-MM-dd');
                                  DateTime selectedDateTime =
                                      inputFormat.parse(selectedDate);
                                  if (selectedDateTime!.isAfter(now)) {
                                    return "Tanggal tidak bisa setelah hari ini";
                                  }
                                  return null;
                                }),
                                controller: tglLahirController,
                                hintTxt: "Tanggal Lahir",
                                helperTxt: "ex: 2022-06-12",
                                iconData: Icons.calendar_today),
                            InputForm(
                                key: Key('telpField'),
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
                                key: Key('emailField'),
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
                                key: Key('passwordField'),
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
                              height: 3.h,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    minimumSize: Size(100.w, 6.h)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (await UserClient.checkEmail(
                                            emailController.text) ==
                                        false) {
                                      await addUser();
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                actionsPadding: EdgeInsets.only(
                                                    left: 5.w,
                                                    right: 5.w,
                                                    bottom: 3.h),
                                                title: Center(
                                                    child: const Text(
                                                  "Register Success!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                content: const Text(
                                                    "Congratulation you have successfully registered!"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return const LoginView();
                                                          })),
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.grey[400],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          minimumSize:
                                                              Size(100.w, 4.h)),
                                                      child: const Text(
                                                        "OK",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ))
                                                ],
                                              ));
                                    } else {
                                      showToastMessage(
                                          "Tidak bisa register email tidak unik",
                                          Colors.red);
                                    }
                                  }
                                },
                                child: const Text('Register',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.grey,
                                      height: 1.h,
                                    )),
                              ),
                              const Text("or",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.grey,
                                      height: 1.h,
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: 1.h,
                            ),
                            const Text("Already have an account?",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            SizedBox(
                              height: 2.h,
                            ),
                            ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(5)),
                                  minimumSize: Size(100.w, 6.h),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const LoginView();
                                  }), (route) => false);
                                },
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    var user = User(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        noTelp: notelpController.text,
        tglLahir: tglLahirController.text,
        profilePath: "-1",
        bpjs: "-1");
    await UserClient.register(user);
  }
}
