import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'dart:math';

final List<String> doctor = ['Aji', 'Caily', 'Alina', 'Bonita', 'Daisy'];

class ReservationForm extends StatefulWidget {
  const ReservationForm(
      {super.key, required this.date, required this.time, required this.id});
  final String? date, time;
  final int? id;

  @override
  State<ReservationForm> createState() => ReservationFormState();
}

class ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      dateController.text = widget.date!;
      timeController.text = widget.time!;
      isEmpty = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isEmpty ? "Create Reservation" : "Edit Reservation"),
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
                selectedDate: isEmpty ? null : dateController.text,
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
                iconData: Icons.access_time,
                startTime: isEmpty ? null : timeController.text,
              ),
              SizedBox(
                height: 400,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 24, right: 15, left: 15),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              isEmpty ? addReservation() : editReservation();
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all<Size>(const Size(360, 50))),
          child: Text(
            isEmpty ? "Create" : "Edit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Future<void> addReservation() async {
    final String doctorName = doctor[Random().nextInt(5)];
    final String email = "alvian@gmail.com";
    await SQLHelperReservation.addReservation(
        dateController.text, timeController.text, doctorName, email);
  }

  Future<void> editReservation() async {
    await SQLHelperReservation.editReservation(
        dateController.text, timeController.text, widget.id!);
  }
}
