import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:e_document_request/screens/forgotPassword.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBar(),
              SizedBox(
                height: 50.h,
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     Text(
                      "To get started, let’s create an account.",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    LoginForm(),
                    SizedBox(
                      height: 30,
                    ),
                    createAnAccount(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            textFieldForForm("Email*", "Enter your email", "Required"),
            SizedBox(
              height: 20,
            ),
            textFieldForForm("Password*", "Create a password", "Required"),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                  },
                    child: Text(
                  "Recover Password?",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff48A876)),
                ))),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  //   if (_formKey.currentState?.validate() == true) {
                  // Save the form values
                  _formKey.currentState?.save();

                  // Process the data (e.g., send to a server, display in UI)
                  // print('Name: $_name');
                  // print('Email: $_email');

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Enteryourdetails2()));



                  // You can display a success message using a Snackbar
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Logged IN successfully!')),
                  // );

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  //  }
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xff24985B),
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

Widget createAnAccount(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateAccount()));
      },
      child: const Wrap(
        children: [
          Text("Don't have an account? ",
              style: TextStyle(fontSize: 15.0, color: Colors.grey)),
          Text(
            "Create an account",
            style: TextStyle(color: Color(0xff48A876), fontSize: 15.0),
          )
        ],
      ),
    ),
  );
}
