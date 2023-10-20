import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => ReservationFormState();
}

class ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
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
              DatePicker(
                validasi: (value) {
                  if (value == null || value.isEmpty) {
                    return "Date cannot be empty";
                  }
                },
                controller: dateController,
                hintTxt: "Select desired date",
                helperTxt: "",
                iconData: Icons.date_range_rounded,
              ),
              TimePicker(
                  validasi: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select the desired time";
                    }
                  },
                  controller: timeController,
                  hintTxt: "Select desired time",
                  helperTxt: "",
                  iconData: Icons.access_time),
              SizedBox(
                height: 400,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
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
