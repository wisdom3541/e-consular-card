import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:e_document_request/providers/update_nin_data_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Enteryourdetails extends StatelessWidget {
  const Enteryourdetails({super.key});

  @override
  Widget build(BuildContext context) {
    var undp = Provider.of<UpdateNinDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text("Enter Your Details",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "To get started, let’s create an account",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Text("Passport Picture*"),
                  SizedBox(
                    height: 10.h,
                  ),
                  undp.image != null
                      ? Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: FileImage(undp.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.person_outline,
                          size: 150,
                          fill: 1,
                          color: Colors.black,
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      var selcetedImage = await pickAndResizeImage();

                      if (selcetedImage == null) {
                        print("no image selected");
                      } else {
                        undp.updateSelectedImage(selcetedImage);
                      }
                      print(undp.image?.path);
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: takePhoto(),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 20),
                  const EnterDetailsForm(),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: alreadyHaveAccount(context)),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget takePhoto() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Container(
      width: 120,
      child: const Row(
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Select Photo",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

Widget uplaodPicture() {
  return Container(
    width: 250,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(223, 245, 239, 100),
        borderRadius: BorderRadius.circular(5)),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: const Text(
      "Upload Picture from Computer",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(
          36,
          152,
          91,
          100,
        ),
      ),
    ),
  );
}

class EnterDetailsForm extends StatefulWidget {
  const EnterDetailsForm({super.key});

  @override
  State<EnterDetailsForm> createState() => _EnterDetailsFormState();
}

bool editable = false;

class _EnterDetailsFormState extends State<EnterDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store form values
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    var undp = Provider.of<UpdateNinDataProvider>(context);
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldForForm("First Name*", "Enter your first name", "Required",
                undp.firstnameController, editable),
            const SizedBox(
              height: 20,
            ),
            textFieldForForm("Last Name*", "Enter your last name", "Required",
                undp.surnameController, editable),
            const SizedBox(
              height: 20,
            ),
            textFieldForForm("Middle Name*", "Enter your middle name",
                "Optional", undp.middlenameController, editable),
            const SizedBox(
              height: 20,
            ),
            const Align(alignment: Alignment.centerLeft, child: Text("Gender")),
            const SizedBox(
              height: 10,
            ),
            genderDropDown(),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState?.validate() == true && undp.image != null ) {
                    // Save the form values
                    _formKey.currentState?.save();

                    // Process the data (e.g., send to a server, display in UI)
                    print('Name: $_name');
                    print('Email: $_email');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Enteryourdetails2()));

                    // You can display a success message using a Snackbar
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Form successfully submitted!')),
                    // );
                  }else{
                    Fluttertoast.showToast(
            msg: "Please select a passport photo ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0,
          );
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textFieldForForm(String titleText, String hintText,
    String errorMessageText, TextEditingController controller, bool editable) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titleText),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: controller,
        enabled: editable,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        // keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessageText;
          }
          return null;
        },
        onSaved: (value) {
          //_email = value ?? '';
        },
      ),
    ],
  );
}

Widget genderDropDown() {
  return Container(
    constraints: const BoxConstraints(minWidth: double.infinity),
    decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: DropdownButton<String>(
      //style: TextStyle(fontWeight: FontWeight.w400),
      underline: const SizedBox.shrink(),
      isExpanded: true,
      // Expands the dropdown to full width
      value: "Male",
      // Currently selected value
      items: <String>[
        'Male',
        'Female',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // appState.updateCreateAccountDropdownOption(newValue!);
      },
    ),
  );
}

Future<CompressedImageResult?> pickCompressAndConvertToBase64() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return null;

  File imageFile = File(pickedFile.path);

  // Compress the image
  final dir = await getTemporaryDirectory();
  final targetPath = join(dir.absolute.path, "temp.jpg");

  XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
    imageFile.absolute.path,
    targetPath,
    quality: 60,
  );

  if (compressedImage == null) return null;

  // Convert to Base64
  final bytes = await compressedImage.readAsBytes();
  String base64Image = base64Encode(bytes);

  return CompressedImageResult(file: compressedImage, base64: base64Image);
}

class CompressedImageResult {
  final XFile file;
  final String base64;

  CompressedImageResult({required this.file, required this.base64});
}

Future<File?> pickAndResizeImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return null;

  // Read as bytes and decode using `image` package
  final originalBytes = await pickedFile.readAsBytes();
  final originalImage = img.decodeImage(originalBytes);

  if (originalImage == null) return null;

  // Resize to 600x600
  final resizedImage = img.copyResize(originalImage, width: 600, height: 600);

  // Convert to PNG or JPG bytes
  final resizedBytes = img.encodeJpg(resizedImage);

  // Save resized image to temporary directory
  final tempDir = await getTemporaryDirectory();
  final resizedFile = File(join(tempDir.path, 'resized_passport.jpg'))
    ..writeAsBytesSync(resizedBytes);

  return resizedFile;

  // Now _resizedImage can be sent to backend via multipart/form-data
}
