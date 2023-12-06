import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugd_ui_widget/View/scan_qr_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InputForm extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final bool password;
  final Key key;

  InputForm({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
    this.password = false,
    required this.key,
  });

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: SizedBox(
        child: TextFormField(
          validator: (value) => widget.validasi(value),
          autofocus: false,
          controller: widget.controller,
          obscureText: widget.password && !isPasswordVisible,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            border: const OutlineInputBorder(),
            helperText: widget.helperTxt,
            prefixIcon: Icon(widget.iconData),
            suffixIcon: widget.password
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : null, // Hide the suffix icon if not a password field
          ),
        ),
      ),
    );
  }
}

class ScannerInputForm extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;

  ScannerInputForm({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
  });

  @override
  _ScannerInputFormState createState() => _ScannerInputFormState();
}

class _ScannerInputFormState extends State<ScannerInputForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.h),
      child: SizedBox(
        child: TextFormField(
          validator: (value) => widget.validasi(value),
          autofocus: false,
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            border: const OutlineInputBorder(),
            helperText: widget.helperTxt,
            prefixIcon: Icon(widget.iconData),
            suffixIcon: Ink(
              decoration: const ShapeDecoration(
                  shape: Border(left: BorderSide(width: 0.8))),
              child: IconButton(
                onPressed: () {
                  _navigateAndDisplayToScanner(context);
                },
                icon: const Icon(Icons.qr_code_scanner_outlined),
                iconSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplayToScanner(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerPageView()),
    );
    if (!mounted) return;
    setState(() {
      widget.controller.text = result ?? '';
    });
  }
}

class DatePicker extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final String? selectedDate;
  final Key key;

  DatePicker({
    required this.validasi,
    required this.key,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
    this.selectedDate,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? errorDate;
  DateTime dateNow = DateTime.now();
  DateFormat customDateFormat = DateFormat('yyyy-MM-dd', 'en_US');

  @override
  Widget build(BuildContext context) {
    if (widget.selectedDate != null) {
      String dateString = widget.selectedDate!;
      print(dateString);
      try {
        DateTime parsedDateTime = customDateFormat.parse(dateString);
        dateNow = parsedDateTime;
      } catch (e) {
        print("error parsing dateString: $e");
      } finally {}
    }
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: SizedBox(
        child: TextFormField(
          readOnly: true,
          validator: (value) => widget.validasi(value),
          autofocus: false,
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.iconData),
            labelText: widget.hintTxt,
            helperText: widget.helperTxt,
          ),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: dateNow,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              setState(() {
                widget.controller.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            } else {
              setState(() {
                widget.controller.text = '';
              });
            }
          },
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final String? startTime;

  TimePicker({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
    required this.startTime,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    if (widget.startTime != null) {
      String timeString = widget.startTime!;
      List<String> timeParts = timeString.split(":");
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      TimeOfDay parsedTime = TimeOfDay(hour: hour, minute: minute);

      selectedTime = parsedTime;
    }
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: SizedBox(
        child: TextFormField(
          readOnly: true,
          validator: (value) => widget.validasi(value),
          autofocus: false,
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.iconData),
            labelText: widget.hintTxt,
            helperText: widget.helperTxt,
          ),
          onTap: () async {
            final TimeOfDay? timeOfDay = await showTimePicker(
                context: context, initialTime: selectedTime);

            if (timeOfDay != null) {
              setState(() {
                String formattedTime =
                    "${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')}";
                widget.controller.text = formattedTime;
              });
            } else {
              setState(() {
                widget.controller.text = '';
              });
            }
          },
        ),
      ),
    );
  }
}
