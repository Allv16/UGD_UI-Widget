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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm2(
                (p0) {
                  if(p0 ==null || p0.isEmpty){
                    return 'Username Tidak Boleh Kosong';
                  }
                  if(p0.toLowerCase() == 'anjing'){
                    return 'Tidak Boleh mengginakan kata kasar';
                  }
                  return null;
                },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Ucup Surucup",
                  iconData: Icons.person),

              DatePicker(
                
              ),

              inputForm2(
                ((p0) {
                  if(p0 ==null || p0.isEmpty){
                    return 'Email tidak boleh kosong';
                  }
                  if(!p0.contains('@')){
                    return 'Email harus menggunakan @';
                  }
                  return null;
                }),
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "ucup@gmail.com",
                  iconData: Icons.email),

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


              inputForm2(
                ((p0) {
                  if(p0 ==null || p0.isEmpty){
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  
                  return null;
                }),
                  controller: notelpController,
                  hintTxt: "No Telp",
                  helperTxt: "082123456789",
                  iconData: Icons.phone_android),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    Map<String,dynamic> formData = {};
                    formData['username'] = usernameController.text;
                    formData['password'] = passwordController.text;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData ,)));
                  }
                },
                child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}
