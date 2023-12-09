import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:uuid/uuid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/View/edit_reservation_success.dart';

final List<String> doctor = ['Aji', 'Caily', 'Alina', 'Bonita', 'Daisy'];

class ReservationForm extends StatefulWidget {
  const ReservationForm(
      {super.key,
      required this.date,
      required this.time,
      required this.id,
      this.bpjs});
  final String? date, time, bpjs;
  final String? id;

  @override
  State<ReservationForm> createState() => ReservationFormState();
}

class ReservationFormState extends State<ReservationForm> {
  String emailUser = "";
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    setState(() {
      emailUser = email!;
    });
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController bpjsController = TextEditingController();
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      dateController.text = widget.date!;
      timeController.text = widget.time!;
      isEmpty = false;
    }
    if (widget.bpjs != null) {
      bpjsController.text = widget.bpjs!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isEmpty ? "Create Reservation" : "Edit Reservation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.px),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.px,
                ),
                DatePicker(
                  key: const ValueKey("date"),
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
                  key: const ValueKey("time"),
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
                ScannerInputForm(
                    key: const ValueKey("bpjs"),
                    validasi: (value) {
                      if (value?.length != 13 && value!.isNotEmpty) {
                        return "Nomer kartu BPJS harus 13 digit. sekarang hanya ada ${value.length}";
                      }
                    },
                    controller: bpjsController,
                    hintTxt: "Masukkan nomor BPJS Anda",
                    helperTxt: "",
                    iconData: Icons.credit_card),
                SizedBox(
                  height: 377.px,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15.h, right: 15.w, left: 15.w),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              isEmpty ? addReservation() : editReservation();
             // Navigator.pop(context);
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditReservationSuccess(
                  doctorName: doctor[Random().nextInt(5)], // Pass actual doctor's name here or update as needed
                  date: dateController.text,
                  time: timeController.text,
                ),
              ),
            );
          }
        },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(40.w, 7.h))),
          child: Text(
            isEmpty ? "Create" : "Edit",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }

  Future<void> addReservation() async {
    final String doctorName = doctor[Random().nextInt(5)];
    await SQLHelperReservation.addReservation(Uuid().v1(), dateController.text,
        timeController.text, doctorName, emailUser, bpjsController.text);
  }

  Future<void> editReservation() async {
    await SQLHelperReservation.editReservation(dateController.text,
        timeController.text, widget.id!, bpjsController.text);
  }
}
