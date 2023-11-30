import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/model/user.dart';
import 'package:ugd_ui_widget/client/userClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugd_ui_widget/View/home.dart';

//testing
import 'package:ugd_ui_widget/utils/custom_formatter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xFF1B90B8),
          Color.fromARGB(221, 27, 145, 184),
          Color.fromARGB(162, 27, 145, 184),
        ])),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                'images/login-rv.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    padding: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
                    child: Column(
                      children: [
                        Text(
                          "LOGIN",
                          style: GoogleFonts.raleway(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(children: [
                              InputForm(
                                  key: Key('emailField'),
                                  validasi: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                  },
                                  controller: emailController,
                                  hintTxt: "Email",
                                  helperTxt: "",
                                  iconData: Icons.email),
                              InputForm(
                                  key: Key('passwordField'),
                                  validasi: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password cannot be empty';
                                    }
                                    return null;
                                  },
                                  password: true,
                                  controller: passwordController,
                                  hintTxt: "Password",
                                  helperTxt: "",
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
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    User? loginResult =
                                        await UserClient.login(email, password);
                                    if (loginResult != null) {
                                      //set sharedpreferenced
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'username', loginResult.username);
                                      prefs.setString(
                                          'email', loginResult.email);
                                      prefs.setString(
                                          'noTelp', loginResult.noTelp);
                                      prefs.setString(
                                          'password', loginResult.password);
                                      prefs.setString(
                                          'tglLahir', loginResult.tglLahir);
                                      loginResult.profilePath == '1'
                                          ? prefs.setString('profilePath', '')
                                          : prefs.setString('profilePath',
                                              loginResult.profilePath);

                                      showToastMessage("Login Successful",
                                          Colors.green[400]);

                                      // Continue to the home page or another screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const HomeView(),
                                        ),
                                      );
                                    } else {
                                      // Login failed
                                      showToastMessage(
                                          "Email or password are incorrect.\nPlease try again.",
                                          Colors.red[400]);
                                    }
                                  }
                                },
                                child: Text("Login",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ])),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
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
                        const Text("Don't have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        SizedBox(
                          height: 2.h,
                        ),
                        ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              minimumSize: Size(100.w, 6.h),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const RegisterView();
                              }));
                            },
                            child: Text("Register",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)))
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Future<User?> login(String username, String password) async {
    return await UserClient.login(username, password);
  }
}

void showToastMessage(msg, color) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.grey[200],
      fontSize: 14.sp,
    );
