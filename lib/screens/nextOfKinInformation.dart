import 'package:e_document_request/providers/verify_nin_provider.dart';
import 'package:e_document_request/screens/accountCreatedSuccessfully.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool editable = true;

class NextOfKinInformation extends StatelessWidget {
  const NextOfKinInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            const SizedBox(
              height: 30,
            ),
            backIcon(),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                children: [

                  SizedBox(height: 20,),
                  Text(
                    "Last step, Next off Kin Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Great, your account is almost ready, provide\nthe following details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),

                  NextofkininformationForm()

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NextofkininformationForm extends StatefulWidget {
  const NextofkininformationForm({super.key});

  @override
  State<NextofkininformationForm> createState() => _NextofkininformationFormState();
}

class _NextofkininformationFormState extends State<NextofkininformationForm> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var vnp = Provider.of<VerifyNinProvider>(context);
    return  Container(
      child: Form(
        key: _formKey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldForForm("First Name*","Enter their first name", "Required",vnp.nokFirstnameController,editable),
            const SizedBox(height: 20,),
            textFieldForForm("Last Name*","Enter their last name", "Required",vnp.nokSurnameController,editable),
            const SizedBox(height: 20,),
            textFieldForForm("Middle Name","Enter their middle name", "Optional",vnp.nokMiddlenameController,editable),
            const SizedBox(
              height: 20,
            ),
            textFieldForForm("Phone Number","080-xxx-xxxx", "Required",vnp.nokTelephonenoController,editable),
            const SizedBox(
              height: 20,
            ),
            textFieldForForm("Relationship","Mother", "Required",vnp.nokRelationshipController,editable),
            const SizedBox(
              height: 20,
            ),
            textFieldForForm("Email*","Enter their email", "Required",vnp.nokEmailController,editable),


            const SizedBox(height: 50,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                //  if (_formKey.currentState?.validate() == true) {
                    // Save the form values
                    _formKey.currentState?.save();

                    // Process the data (e.g., send to a server, display in UI)
                  //  print('Name: $_name');
                   // print('Email: $_email');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Accountcreatedsuccessfully()));

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

