import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:e_document_request/screens/nextOfKinInformation.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Enteryourdetails2 extends StatelessWidget {
  const Enteryourdetails2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            SizedBox(height: 20),
            backIcon(),
            //SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Almost there, Complete your profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Great, your account is almost ready, provide\nthe following details",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  EnterDetailsForm2()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EnterDetailsForm2 extends StatefulWidget {
  const EnterDetailsForm2({super.key});

  @override
  State<EnterDetailsForm2> createState() => _EnterDetailsForm2State();
}

class _EnterDetailsForm2State extends State<EnterDetailsForm2> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldForForm(
                "Address of Residence", "Enter your address", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm("LGA", "Enter your LGA", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm("State of Residence",
                "Enter your state of residence", "Required"),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            InputDatePickerFormField(
                fieldLabelText: "Date of Birth",
                fieldHintText: "Enter your D.O.B",
                firstDate: DateTime(1924, 01, 01),
                lastDate: DateTime(2009, 01, 01)),
            SizedBox(
              height: 20,
            ),
            textFieldForForm(
                "State of Origin", "Enter your state of origin", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm("Country of Residence",
                "Enter your country of residence", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm(
                "Means of Identification", "Select ID type", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm("Enter ID Number", "0123456789", "Required"),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                //  if (_formkey.currentState?.validate() == true) {
                    // Save the form values
                    _formkey.currentState?.save();

                    // Process the data (e.g., send to a server, display in UI)
                    // print('Name: $_name');
                    // print('Email: $_email');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NextOfKinInformation()));

                    // You can display a success message using a Snackbar
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Form successfully submitted!')),
                    // );
                //  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
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
        ),
      ),
    );
  }
}
