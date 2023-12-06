import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
// import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:uuid/uuid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/client/reservationClient.dart';
import 'package:ugd_ui_widget/entity/Reservation.dart';

final List<String> doctor = ['Aji', 'Caily', 'Alina', 'Bonita', 'Daisy'];

class ReservationForm extends StatefulWidget {
  const ReservationForm(
      {super.key,
      required this.date,
      required this.time,
      required this.id,
      this.bpjs});
  final String? date, time, bpjs;
  final int id;
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

  void loadData() async {
    try {
      Reservation res = await ReservationClient.find(widget.id);
      setState(() {
        dateController.value = TextEditingValue(text: res.date);
        timeController.value = TextEditingValue(text: res.praktek.jamPraktek);
        bpjsController.value = TextEditingValue(text: res.hasBPJS.toString());
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
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
  final String doctorName = doctor[Random().nextInt(5)];
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

    void onSubmit() async {
      if (!_formKey.currentState!.validate()) return;

      try {
        if (widget.id == -1) {
          await ReservationClient.create(
              emailUser, dateController.text, true, 1);
        } else {
          await ReservationClient.update(
              widget.id, emailUser, dateController.text, true, 1);
        }
        showSnackBar(context, 'Success', Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEmpty ? "Create Reservation" : "Edit Reservation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                DatePicker(
                  key: const Key("dateField"),
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
                ScannerInputForm(
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
          onPressed: onSubmit,
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

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        action: SnackBarAction(
          label: 'hide',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
