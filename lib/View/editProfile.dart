import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/login.dart';
import 'package:ugd_ui_widget/View/register.dart';
import 'package:ugd_ui_widget/component/form_component.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                const SizedBox(
                  height: 400,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
                      formData['notelp'] = notelpController.text;
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: const Text("Edit Success!"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginView(
                                                    data: formData,
                                                  ))),
                                      child: const Text("EDIT"))
                                ],
                              ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(376, 50),
                  ),
                  child: const Text('Edit',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
