// import 'package:e_consular_card/models/register_user.dart';
// import 'package:e_consular_card/providers/create_acccount_with_nin_provider.dart';
// import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
// import 'package:e_consular_card/screens/enterYourDetails.dart';
// import 'package:e_consular_card/screens/otpScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CreateAccountWithNIN extends StatelessWidget {
//   const CreateAccountWithNIN({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             appBar(),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Column(
//                 children: [
//                   SizedBox(height: 30.h),
//                   Text(
//                     "Create an account",
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Get your account ready to get any confidential\ndocument you need to.",
//                     style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 30.h),
//                   const CreateAccountWithNinForm(),
//                   SizedBox(height: 20.h),
//                   Align(
//                     alignment: Alignment.center,
//                     child: alreadyHaveAccount(context),
//                   ),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CreateAccountWithNinForm extends StatefulWidget {
//   const CreateAccountWithNinForm({super.key});

//   @override
//   _CreateAccountWithNinForm createState() => _CreateAccountWithNinForm();
// }

// TextEditingController passwordController = TextEditingController();
// TextEditingController confirmPasswordController = TextEditingController();

// class _CreateAccountWithNinForm extends State<CreateAccountWithNinForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _nin = '';
//   String _email = '';
//   String _password = '';

//   @override
//   Widget build(BuildContext context) {
//     var appState = Provider.of<CreateAcccountWithNinProvider>(context);
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text("Email*", style: TextStyle(fontSize: 14.sp)),
//           SizedBox(height: 10.h),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: "Enter your Email",
//               hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//             onSaved: (value) => _email = value ?? '',
//           ),
//           SizedBox(height: 16.h),
//           Text("National Identity Number(NIN)*",
//               style: TextStyle(fontSize: 14.sp)),
//           SizedBox(height: 10.h),
//           TextFormField(
//             controller: appState.ninController,
//             decoration: InputDecoration(
//               enabled: false,
//               hintText: "Enter your NIN",
//               hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.length != 11) {
//                 return 'NIN must be 11 characters';
//               }
//               return null;
//             },
//             onSaved: (value) => _nin = value ?? '',
//           ),
//           SizedBox(height: 16.h),
//           PasswordField(title: "Password*",hint:  "Create a Password",controller:  passwordController,
//             validator:   passwordValidation),
//           SizedBox(height: 16.h),
//           PasswordField(title:  "Confirm Password*",hint:  "Confirm  Password",
//              controller:  confirmPasswordController,validator:  cofirmPasswordValidation),
//           SizedBox(height: 30.h),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   //If valid, save form values
//                   _formKey.currentState!.save();
//                   var password = passwordController.text;
//                   print("Email: $_email");
//                   print("nin: $_nin");
//                   print("Password: $password");

//                   var registerUser = RegisterUser(
//                       emailAddress: _email, nin: _nin, password: password);

//                   showLoadingSpinner(context);
//                   await appState.createAccountOnClick(context, registerUser);

//                   Navigator.of(context).pop();

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Form submitted successfully!')),
//                   );

//                   //confirmPasswordController.dispose();
//                   //passwordController.dispose();

//                   Navigator.pushAndRemoveUntil(
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
//                 } else {
//                   // If validation failed
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Please fix the errors')),
//                   );
//                 }
//               },
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               ),
//               child: Text(
//                 "Create Account",
//                 style: TextStyle(color: Colors.white, fontSize: 16.sp),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PasswordField extends StatefulWidget {
//   final String title;
//   final String hint;
//   final TextEditingController controller;
//   final String? Function(String? value) validator;

//   const PasswordField({
//     Key? key,
//     required this.title,
//     required this.hint,
//     required this.controller,
//     required this.validator,
//   }) : super(key: key);

//   @override
//   State<PasswordField> createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool obscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title, style: TextStyle(fontSize: 14.sp)),
//         SizedBox(height: 10.h),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: obscure,
//           validator: widget.validator,
//           decoration: InputDecoration(
//             hintText: widget.hint,
//             hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.r)),
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 obscure ? Icons.visibility_off : Icons.visibility,
//                 color: Colors.grey,
//               ),
//               onPressed: () {
//                 setState(() => obscure = !obscure);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



// String? passwordValidation(String? val) {
//   if (val == null ||
//       !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$')
//           .hasMatch(val)) {
//     return 'Password must include:\n- 1 uppercase letter\n- 1 number\n- 1 special character\n- 8+ characters';
//   }
//   return null;
// }

// String? cofirmPasswordValidation(String? val) {
//   if (val == null ||
//       passwordController.text != confirmPasswordController.text) {
//     return 'Password does not match';
//   }
//   return null;
// }

// // Function to show a circular loader for 3 seconds
// void showLoadingSpinner(BuildContext context) {
//   // Show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevent dismissal by tapping outside
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//         content: const SizedBox(
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 20),
//               Text("Please wait...", style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// // Widget createAccountButton(BuildContext context) {
// //   var appState = Provider.of<CreateAcccountWithNinProvider>(context);
// //   return Container(
// //     width: double.infinity,
// //     height: 50,
// //     child: FilledButton(
// //       onPressed: () {
// //         appState.createAccountButtonSelect(context);
// //       },
// //       child: Text(
// //         appState.buttonValue,
// //         style: TextStyle(color: Colors.white),
// //       ),
// //       style: ButtonStyle(
// //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
// //           backgroundColor: MaterialStateProperty.all<Color>(
// //             Colors.green,
// //           ),
// //           foregroundColor: MaterialStateProperty.all<Color>(
// //             Colors.white,
// //           )),
// //     ),
// //   );
// // }
