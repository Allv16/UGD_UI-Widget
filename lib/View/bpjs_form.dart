import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/component/form_component.dart';
import 'package:ugd_ui_widget/client/userClient.dart';

class BPJSForm extends StatefulWidget {
  final String bpjs;
  final String email;
  final String username;
  const BPJSForm(
      {Key? key,
      required this.bpjs,
      required this.email,
      required this.username})
      : super(key: key);

  @override
  State<BPJSForm> createState() => _BPJSFormState();
}

class _BPJSFormState extends State<BPJSForm> {
  final TextEditingController _bpjsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _hasBPJS = false;

  @override
  void initState() {
    super.initState();
    _hasBPJS = widget.bpjs == '-1' ? false : true;
    loadBPJS();
  }

  Future loadBPJS() async {
    setState(() {
      _hasBPJS ? _bpjsController.text = widget.bpjs : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage BPJS',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              _hasBPJS
                  ? Card(
                      margin: const EdgeInsets.all(0),
                      child: Container(
                        width: double.infinity,
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF94A684),
                              Color(0xFFAEC3AE),
                              Color(0xFF94A684),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BPJS",
                                style: GoogleFonts.roboto(
                                    color: const Color(0xFFFFEEF4),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 1.5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(widget.bpjs[0],
                                      style: GoogleFonts.openSans(
                                        color: const Color(0xFFFFEEF4),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(width: 4.w),
                                  Text(widget.bpjs.substring(1, 5),
                                      style: GoogleFonts.openSans(
                                        color: const Color(0xFFFFEEF4),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(width: 4.w),
                                  Text(widget.bpjs.substring(5, 9),
                                      style: GoogleFonts.openSans(
                                        color: const Color(0xFFFFEEF4),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(width: 4.w),
                                  Text(widget.bpjs.substring(9, 13),
                                      style: GoogleFonts.openSans(
                                        color: const Color(0xFFFFEEF4),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              SizedBox(height: 1.5.h),
                              Text("Card Holder",
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xFFFFEEF4),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic)),
                              Text(widget.username,
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xFFFFEEF4),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: 3.h),
              Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.triangleExclamation,
                              size: 16.sp,
                              color: const Color(0xFFFFCC00),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                                "Please read the following information carefully.",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "You can choose wheter you want to use BPJS or not in the reservation page.",
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Before you proceed, please be informed that our application requires access to and save your BPJS number for the purpose of making a reservation and verifying your identity. We take the privacy and security of your personal information seriously.",
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                            "To edit your BPJS number, please edit the form below.",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 1.h),
                        ScannerInputForm(
                            validasi: (value) {
                              if (value?.length != 13 && value!.isNotEmpty) {
                                return "The BPJS number must be 13 digits. Currently, it has ${value.length} digits.";
                              }
                              if (value!.isEmpty)
                                return "Must filled this field";
                            },
                            controller: _bpjsController,
                            hintTxt: "Insert your BPJS number",
                            helperTxt:
                                "You can scan or type your BPJS number manually.",
                            iconData: FontAwesomeIcons.idCard),
                        SizedBox(height: 3.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              minimumSize: Size(100.w, 6.h)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              await UserClient.updateBPJS(
                                  widget.email, _bpjsController.text);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('bpjs', _bpjsController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileView()));
                            }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        SizedBox(height: 1.h),
                        _hasBPJS
                            ? Column(
                                children: [
                                  Row(children: <Widget>[
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          child: Divider(
                                            color: Colors.grey,
                                            height: 1.h,
                                          )),
                                    ),
                                    const Text("or",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20.0, right: 10.0),
                                          child: Divider(
                                            color: Colors.grey,
                                            height: 1.h,
                                          )),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  ElevatedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.redAccent
                                                    .withOpacity(0.8),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        minimumSize: Size(100.w, 6.h),
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  actionsPadding:
                                                      EdgeInsets.only(
                                                          left: 5.w,
                                                          right: 5.w,
                                                          bottom: 3.h),
                                                  title: const Center(
                                                      child: Text(
                                                    "Delete BPJS Number",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                                  content: const Text(
                                                      "Are you sure want to delete your BPJS number?"),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        400],
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                minimumSize:
                                                                    Size(30.w,
                                                                        4.h)),
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async => {
                                                                      setState(
                                                                          () {
                                                                        _isLoading =
                                                                            true;
                                                                      }),
                                                                      await UserClient.updateBPJS(
                                                                          widget
                                                                              .email,
                                                                          "-1"),
                                                                      await SharedPreferences
                                                                              .getInstance()
                                                                          .then(
                                                                              (prefs) {
                                                                        prefs.setString(
                                                                            'bpjs',
                                                                            '-1');
                                                                      }),
                                                                      // ignore: use_build_context_synchronously
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const ProfileView()))
                                                                    },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors
                                                                    .redAccent
                                                                    .withOpacity(
                                                                        0.8),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                minimumSize:
                                                                    Size(30.w,
                                                                        4.h)),
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ));
                                      },
                                      child: Text("Delete",
                                          style: TextStyle(
                                              color: Colors.redAccent
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ],
                              )
                            : const SizedBox(),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
