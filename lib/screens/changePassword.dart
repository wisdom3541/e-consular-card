import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/loginScreen.dart' as login;
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          appBar(),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                backIcon(),
                SizedBox(height: 50,),
                Text("Change Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                SizedBox(height: 5,),
                Text("Get access back into your account, enter your e-mail", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),),
                SizedBox(height: 30,),
                ChangePasswordForm(),


              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        textFieldForForm("Enter New Password*", "create a 8 character password", "required"),
        SizedBox(height: 20,),
        textFieldForForm("Enter New Password*", "create a 8 character password", "required"),
        SizedBox(height: 30,),
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

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const login.LoginScreen() ));

              // You can display a success message using a Snackbar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('Logged IN successfully!')),
              // );
              //  }
            },
            child: Text(
              "Save and Continue",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize: 20),
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
    ));
  }
}

Widget textFieldForForm(String titleText, String hintText, String errorMessageText){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titleText),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
       // controller: controller,
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

