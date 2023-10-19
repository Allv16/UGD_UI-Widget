import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => ReservationFormState();
}

class ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reservation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              InputForm(
                  controller: usernameController,
                  validasi: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username cannot be empty";
                    }
                    if (value.contains('anjing')) {
                      return "Username cannout contain harmful words";
                    }
                  },
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
              SizedBox(
                height: 400,
              ),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(360, 50))),
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
