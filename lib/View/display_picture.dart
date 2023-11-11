import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/profile.dart';
import 'package:ugd_ui_widget/database/sql_helper_user.dart';
import 'dart:io';

import 'package:ugd_ui_widget/utils/logging_utils.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final CameraController cameraController;

  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.cameraController})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? fileResult;
  String? email;
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    fileResult = File(widget.imagePath);
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    LoggingUtils.LogStartFunction("Build DisplayPictureScreen");
    return Scaffold(
      appBar: AppBar(title: const Text("Picture preview")),
      body: WillPopScope(
        onWillPop: () async {
          widget.cameraController.resumePreview();
          return true;
        },
        child: Center(
          child: Column(
            children: [
              Image.file(fileResult!, scale: 0.5),
              const SizedBox(
                height: 64,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                RawMaterialButton(
                  onPressed: () {
                    widget.cameraController.resumePreview();
                    Navigator.pop(context);
                  },
                  fillColor: Colors.grey[800],
                  padding: const EdgeInsets.all(15),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.grey[300],
                  ),
                ),
                RawMaterialButton(
                  onPressed: saveImageToPermanentStorage,
                  fillColor: Colors.grey[800],
                  padding: const EdgeInsets.all(15),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.check,
                    size: 32,
                    color: Colors.grey[300],
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveImageToPermanentStorage() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final permanentDirectory =
        Directory('${appDocumentsDirectory.path}/userProfile');
    if (!await permanentDirectory.exists()) {
      await permanentDirectory.create(recursive: true);
    }
    DateTime date = DateTime.now();
    String newFileName = date.toString();
    newFileName = newFileName.replaceAll(" ", "_");
    print(newFileName);
    final fileName =
        '$email-$newFileName.png'; // Change this to your desired filename.
    final permanentImagePath = '${permanentDirectory.path}/$fileName';

    try {
      await fileResult?.copy(permanentImagePath);
      print(permanentImagePath);
      await SQLHelperUser.editProfile(permanentImagePath, email!);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profilePath', permanentImagePath);
      // Provide user feedback that the image has been saved.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil memperbaharui foto profile'),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileView()));
    } catch (e) {
      print('Error saving image: $e');
      // Handle the error if there was an issue saving the image.
    }
  }
}
