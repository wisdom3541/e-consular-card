import 'dart:io';
import 'dart:convert'; // for base64Encode
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photopicker extends StatefulWidget {
  const Photopicker({super.key});

  @override
  _Photopicker createState() => _Photopicker();
}

class _Photopicker extends State<Photopicker> {
  File? _imageFile;
  String? _base64Image;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      setState(() {
        _imageFile = imageFile;
        _base64Image = base64Image;
      });

      print("✅ Base64 Encoded Image:\n$base64Image");
    } else {
      print("❌ No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convert Image to Base64')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick and Convert Image"),
            ),
            SizedBox(height: 10),
            _base64Image != null
                ? Text(
                    "Image encoded to Base64!",
                    style: TextStyle(color: Colors.green),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
