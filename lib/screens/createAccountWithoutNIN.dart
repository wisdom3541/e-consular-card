// import 'dart:io';
// import 'package:e_consular_card/providers/register_without_nin_provider.dart';
// import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
// import 'package:e_consular_card/screens/createAccountWithNIN.dart';
// import 'package:e_consular_card/screens/enterYourDetails.dart';
// import 'package:e_consular_card/screens/loginScreen.dart';
// import 'package:e_consular_card/screens/otpScreen.dart';
// import 'package:e_consular_card/screens/widgets/filePickerField.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';

// class CreateAccountWithoutNIN extends StatelessWidget {
//   const CreateAccountWithoutNIN({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             appBar(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   const Text(
//                     "Create an account",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     "Get your account ready to get any confidential\ndocument you need to.",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   MyForm(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Align(
//                       alignment: Alignment.center,
//                       child: alreadyHaveAccount(context)),
//                   const SizedBox(
//                     height: 20,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// class MyForm extends StatefulWidget {
//   const MyForm({super.key});

//   @override
//   MyFormState createState() => MyFormState();
// }

// class MyFormState extends State<MyForm> {
//   // Create a GlobalKey that uniquely identifies the Form widget
//   // and allows validation of the form.
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController passwordController = TextEditingController();
// TextEditingController confirmPasswordController = TextEditingController();

//   // Variables to store form values
//   String _password = '';
//   String _email = '';

//   @override
//   Widget build(BuildContext context) {
//     var rwnp = Provider.of<RegisterWithoutNinProvider>(context);
//     File? selectedImage;
//     return Form(
//       // Associate the form with a key
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // Email field
//           const Text("Email*"),
//           const SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//                 hintText: "Enter your Email",
//                 hintStyle: TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)))),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null; // Return null if the input is valid
//             },
//             onSaved: (value) {
//               _email = value ?? '';
//             },
//           ),
//           const SizedBox(height: 16.0),

//           // birth certificate field
//           const Text("Select Birth Certificate*"),
//           const SizedBox(
//             height: 10,
//           ),

//           FilePickerField(
//             onPickFile: () async {
//               selectedImage = await pickAndResizeImage(false);
//               return selectedImage;
//             },
//           ),

//           //const SizedBox(height: 16.0),

//           SizedBox(height: 16.h),
//           PasswordField(title: "Password*",hint:  "Create a Password",controller:  passwordController,
//              validator:  passwordValidation),
//           SizedBox(height: 16.h),
//           PasswordField(title: "Confirm Password*",hint:  "Confirm  Password",
//              controller:  confirmPasswordController, validator:  cofirmPasswordValidation),

//           // // Email field
//           // const Text("Password*"),
//           // const SizedBox(
//           //   height: 10,
//           // ),
//           // TextFormField(
//           //   decoration:  InputDecoration(
//           //       hintText: "Create a password",
//           //       hintStyle: TextStyle(color: Colors.grey),
//           //       border: OutlineInputBorder(
//           //           borderRadius: BorderRadius.all(Radius.circular(10.r)))),
//           //   // keyboardType: TextInputType.emailAddress,
//           //   validator: (val) {
//           //     if (val == null ||
//           //         !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$')
//           //             .hasMatch(val)) {
//           //       return 'Password must include:\n- 1 uppercase letter\n- 1 number\n- 1 special character\n- 8+ characters';
//           //     }
//           //     return null;
//           //   },
//           //   onSaved: (value) {
//           //     _password = value ?? '';
//           //   },
//           // ),
//           // const SizedBox(
//           //   height: 10,
//           // ),
//           // const Text("Must be at least 8 characters."),
//           // const SizedBox(height: 16.0),

//           // const Text("Confirm Password*"),
//           // const SizedBox(
//           //   height: 10,
//           // ),
//           // TextFormField(
//           //   decoration: const InputDecoration(
//           //       hintText: "Create a password",
//           //       hintStyle: TextStyle(color: Colors.grey),
//           //       border: OutlineInputBorder(
//           //           borderRadius: BorderRadius.all(Radius.circular(10)))),
//           //   // keyboardType: TextInputType.emailAddress,
//           //   validator: (value) {
//           //     if (value == null || value.isEmpty) {
//           //       return 'Password does not match';
//           //     }
//           //     return null;
//           //   },
//           //   onSaved: (value) {
//           //     _password = value ?? '';
//           //   },
//           // ),
//           // const SizedBox(
//           //   height: 10,
//           // ),
//           // const Text("Must be at least 8 characters."),

//           const SizedBox(
//             height: 30,
//           ),

//           // Submit button

//           Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (selectedImage == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Select Birth Certificate')),
//                   );
//                   print("No file was selected.");
//                   return;
//                 }

//                 String filePath =
//                     selectedImage!.path; 
//                 String fileName =
//                     basename(filePath); 
//                 print(filePath);
//                 print(fileName);

//                 // Validate returns true if the form is valid, or false otherwise.
//                 if (_formKey.currentState?.validate() == true) {
//                    showLoadingSpinner(context);
//                   // Save the form values
//                   _formKey.currentState?.save();

//                   // Process the data (e.g., send to a server, display in UI)
//                   print('Name: $_password');
//                   print('Name: ${passwordController.text}');
//                   print('Email: $_email');
                 
//                   var result = await rwnp.regWithoutNin(context,
//                       _email, passwordController.text, filePath, fileName);
//                       Navigator.pop(context);

//                       if(result){

//                          Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const OtpScreen(
//                               otpType: "Enter OTP sent to your mail",
//                               otpMessage:
//                                   "We sent an OTP to your email to verify your account",
//                               nextPage: Enteryourdetails(),
//                             )),
//                     (Route<dynamic> route) =>
//                         false, // Remove all previous routes
//                   );

//                       }else{

//                   //faliurre message using a Snackbar
//                   showSnackBar(context, 'Email is already registered to an account..Please log in!');
//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   SnackBar(content: Text('Email is already registered to an account..Please try again!')),
//                   // );
//                   return;
//                       }

//                 }
//               },
//               child: const Text(
//                 "Create Account",
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8))),
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     Colors.green,
//                   ),
//                   foregroundColor: MaterialStateProperty.all<Color>(
//                     Colors.white,
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String? cofirmPasswordValidation(String? val) {
//   if (val == null ||
//       passwordController.text != confirmPasswordController.text) {
//     return 'Password does not match';
//   }
//   return null;
// }
// }
