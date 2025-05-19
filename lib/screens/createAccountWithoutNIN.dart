import 'package:e_document_request/providers/create_acccount_with_nin_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountWithoutNIN extends StatelessWidget {
  const CreateAccountWithoutNIN({super.key});

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
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Create an account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Get your account ready to get any confidential\ndocument you need to.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyForm(),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: alreadyHaveAccount(context)),
                  SizedBox(
                    height: 20,
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

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // Create a GlobalKey that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Variables to store form values
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      // Associate the form with a key
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email field
          const Text("Email*"),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null; // Return null if the input is valid
            },
            onSaved: (value) {
              _name = value ?? '';
            },
          ),
          const SizedBox(height: 16.0),

          // Name field
          const Text("National Identity Number(NIN)*"),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter your NIN",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            validator: (value) {
              if (value == null ||
                  !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$')
                      .hasMatch(value)) {
                return 'Password must include:\n- 1 uppercase letter\n- 1 number\n- 1 special character\n- 8+ characters';
              }
              return null;
            },
            onSaved: (value) {
              _name = value ?? '';
            },
          ),
          const SizedBox(height: 16.0),

          // Email field
          Text("Password*"),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Create a password",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            // keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              _email = value ?? '';
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Must be at least 8 characters."),
          SizedBox(height: 16.0),

          Text("Confirm Password*"),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Create a password",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            // keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password does not match';
              }
              return null;
            },
            onSaved: (value) {
              _email = value ?? '';
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text("Must be at least 8 characters."),

          SizedBox(
            height: 30,
          ),

          // Submit button

          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                // if (_formKey.currentState?.validate() == true) {
                // Save the form values
                _formKey.currentState?.save();

                // Process the data (e.g., send to a server, display in UI)
                print('Name: $_name');
                print('Email: $_email');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpScreen(
                              otpType: "Enter OTP sent to your mail",
                              otpMessage:
                                  "We sent an OTP to your email to verify your account",
                              nextPage: Enteryourdetails(),
                            )));

                // You can display a success message using a Snackbar
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Form successfully submitted!')),
                // );
                //}
              },
              child: Text(
                "Create Account",
                style: TextStyle(color: Colors.white),
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
    );
  }
}
