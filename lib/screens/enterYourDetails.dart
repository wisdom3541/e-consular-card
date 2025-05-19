import 'package:e_document_request/providers/verify_nin_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Enteryourdetails extends StatelessWidget {
  const Enteryourdetails({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 50,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text("Enter Your Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "To get started, let’s create an account",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Passport Picture*"),
                  const Icon(
                    Icons.person_outline,
                    size: 80,
                   fill: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ), child: takePhoto(),),
                  const SizedBox(height: 5),
                  uplaodPicture(),
                  const SizedBox(height: 10,),
                  const Divider(thickness: 2,),
                  const SizedBox(height: 20),
                  const enterDetailsForm(),
                  const SizedBox(height: 30,),
                  Align(
                      alignment: Alignment.center,
                      child: alreadyHaveAccount(context)),
                  const SizedBox(height: 50,)
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
            "Take Photo",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

Widget uplaodPicture(){
  return Container(
    width: 250,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(223, 245, 239, 100)
        ,
      borderRadius: BorderRadius.circular(5)
    ),

    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: const Text(
      "Upload Picture from Computer",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(36, 152, 91, 100,),
      ),
    ),
  );
}

class enterDetailsForm extends StatefulWidget {
  const enterDetailsForm({super.key});

  @override
  State<enterDetailsForm> createState() => _enterDetailsFormState();
}
  bool editable = false;

class _enterDetailsFormState extends State<enterDetailsForm> {

  final _formKey = GlobalKey<FormState>();

  // Variables to store form values
  String _name = '';
  String _email = '';



  @override
  Widget build(BuildContext context) {

    var vnp = Provider.of<VerifyNinProvider>(context);
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textFieldForForm("First Name*","Enter your first name", "Required",vnp.firstnameController,editable),
          const SizedBox(height: 20,),
          textFieldForForm("Last Name*","Enter your last name", "Required",vnp.surnameController,editable),
          const SizedBox(height: 20,),
          textFieldForForm("Middle Name*","Enter your middle name", "Optional",vnp.middlenameController,editable),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Gender")),
          const SizedBox(height: 10,),
          genderDropDown(),

          const SizedBox(height: 50,),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
             //   if (_formKey.currentState?.validate() == true) {
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
              //  }
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
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
            ),
          ),

        ],
      ),),
    );
  }
}

Widget textFieldForForm(String titleText, String hintText, String errorMessageText, TextEditingController controller, bool editable){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titleText),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: controller,
        enabled: editable  ,
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

Widget genderDropDown(){
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

