import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputForm extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final bool password;

  InputForm({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
    this.password = false,
  });

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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

Padding inputForm2(Function(String?) validasi,
    {required TextEditingController controller,
    required String hintTxt,
    required String helperTxt,
    required IconData iconData,
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: SizedBox(
        child: TextFormField(
      validator: (value) => validasi(value),
      autofocus: true,
      controller: controller,
      obscureText: password,
      decoration: InputDecoration(
        hintText: hintTxt,
        border: const OutlineInputBorder(),
        helperText: helperTxt,
        prefixIcon: Icon(iconData),
      ),
    )),
  );
}

class DatePicker extends StatefulWidget {
  final Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;

  DatePicker({
    required this.validasi,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? errorDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
              initialDate: DateTime.now(),
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
