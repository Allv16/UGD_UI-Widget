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
      padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
      child: SizedBox(
        child: TextFormField(
          validator: (value) => widget.validasi(value),
          autofocus: true,
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

Padding inputForm2(Function(String?) validasi, {required TextEditingController controller,
required String hintTxt, required String helperTxt, required IconData iconData, bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: SizedBox(
      child : TextFormField(
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
      )
      ),
  );
}

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _date = TextEditingController();
  String? erorDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20, top: 10),
      child: SizedBox(
        child: TextFormField(
          autofocus: true,
          controller: _date,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: Icon(Icons.calendar_today_rounded),
            labelText: "Select Date",
            helperText: "yyyy-MM-dd",
            errorText: erorDate,
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              setState(() {
                _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }else{
              setState(() {
                erorDate = 'Please select a date';
              });
            }
          },
        ),
      ),
    );
  }
}
