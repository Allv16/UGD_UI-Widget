// import 'package:flutter/material.dart';
// import 'package:ugd_ui_widget/component/form_component.dart';
// import 'package:ugd_ui_widget/View/home.dart';
// import 'package:ugd_ui_widget/View/register.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ugd_ui_widget/database/sql_helper_user.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:ugd_ui_widget/model/user.dart';
// import 'package:ugd_ui_widget/client/userClient.dart';

// class LoginViewOld extends StatefulWidget {
//   const LoginViewOld({super.key});

//   @override
//   State<LoginViewOld> createState() => _LoginViewOldState();
// }

// class _LoginViewOldState extends State<LoginViewOld> {
//   final _formKey = GlobalKey<FormState>();
//   int userID = -1;
//   List<Map<String, dynamic>> user = [];

//   @override
//   void initState() {
//     refresh();
//     super.initState();
//   }

//   void refresh() async {
//     final data = await SQLHelperUser.getUser();
//     setState(() {
//       user = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Colors.lightBlue,
//                     fontSize: 25.sp,
//                     fontWeight: FontWeight.w800),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     InputForm(
//                       validasi: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Email cannot be empty';
//                         }
//                         return null;
//                       },
//                       controller: emailController,
//                       hintTxt: "Email",
//                       helperTxt: "",
//                       iconData: Icons.email,
//                     ),
//                     InputForm(
//                         validasi: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Password cannot be empty';
//                           }
//                           return null;
//                         },
//                         password: true,
//                         controller: passwordController,
//                         hintTxt: "Password",
//                         helperTxt: "",
//                         iconData: Icons.password),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // tombol login
//                         ElevatedButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               String email = emailController.text;
//                               String password = passwordController.text;
//                               User? loginResult =
//                                   await UserClient.login(email, password);
//                               print(loginResult);
//                               if (loginResult != null) {
//                                 //set sharedpreferenced
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 prefs.setString(
//                                     'username', loginResult.username);
//                                 prefs.setString('email', loginResult.email);
//                                 prefs.setString('noTelp', loginResult.noTelp);
//                                 prefs.setString(
//                                     'password', loginResult.password);
//                                 prefs.setString(
//                                     'tglLahir', loginResult.tglLahir);
//                                 loginResult.profilePath == '1'
//                                     ? prefs.setString('profilePath', '')
//                                     : prefs.setString(
//                                         'profilePath', loginResult.profilePath);

//                                 showToastMessage(
//                                     "Login Successful", Colors.green);

//                                 // Continue to the home page or another screen
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const HomeView(),
//                                   ),
//                                 );
//                               } else {
//                                 // Login failed
//                                 showToastMessage("Login Failed", Colors.red);
//                               }
//                             }
//                           },
//                           child: const Text('login'),
//                         ),

//                         TextButton(
//                             onPressed: () {
//                               pushRegister(context);
//                             },
//                             child: const Text("Belum punya akun ?")),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void pushRegister(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const RegisterView(
//           title: 'REGISTER USER',
//           id: null,
//           username: null,
//           email: null,
//           password: null,
//           tglLahir: null,
//           notelp: null,
//         ),
//       ),
//     );
//   }
// }

// void showToastMessage(msg, color) => Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: color,
//       textColor: Colors.grey[200],
//       fontSize: 15.sp,
//     );
