import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: SizedBox(
        width: 350,
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
