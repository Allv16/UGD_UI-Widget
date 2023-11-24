import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart'; // Import library for getting application documents directory
import 'camera.dart';


class editPhoto extends StatefulWidget {
  const editPhoto(File imageTemp, {Key? key}) : super(key: key);

  @override
  State<editPhoto> createState() => _editPhotoState();
}

class _editPhotoState extends State<editPhoto> {
  File? image;

Future<void> updateProfilePhoto(File imageFile) async {
}

 Future pickImage() async {
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    final imageTemp = File(pickedImage.path);
    setState(() => this.image = imageTemp);

    // Menyimpan gambar sementara
    await saveTemporaryImage(imageTemp);

    // Memanggil fungsi update foto profil
    await editPhoto(imageTemp);
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
}


  // Fungsi untuk menyimpan gambar ke penyimpanan sementara
  Future<void> saveTemporaryImage(File imageTemp) async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final temporaryDirectory = Directory('${appDocumentsDirectory.path}/temporaryProfile');
    if (!await temporaryDirectory.exists()) {
      await temporaryDirectory.create(recursive: true);
    }
    DateTime date = DateTime.now();
    String newFileName = date.toString();
    newFileName = newFileName.replaceAll(" ", "_");
    final fileName = 'temp_$newFileName.png'; // Ganti dengan nama file yang diinginkan.
    final temporaryImagePath = '${temporaryDirectory.path}/$fileName';

    try {
      await imageTemp.copy(temporaryImagePath);
      print(temporaryImagePath);
    } catch (e) {
      print('Error saving temporary image: $e');
    }
  }

// ...

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Photo'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Tambahkan widget untuk menampilkan foto profil
          image != null
              ? Image.file(image!, height: 150, width: 150, fit: BoxFit.cover)
              : Container(),

          // ... (widget lainnya)

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraView()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Ambil Gambar dari Kamera',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: pickImage,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Pilih Gambar dari Galeri',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
