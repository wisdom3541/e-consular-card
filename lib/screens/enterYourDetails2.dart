// import 'package:e_consular_card/providers/app_provider.dart';
// import 'package:e_consular_card/providers/update_nin_data_provider.dart';
// import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
// import 'package:e_consular_card/screens/enterYourDetails.dart';
// import 'package:e_consular_card/screens/nextOfKinInformation.dart';
// import 'package:e_consular_card/screens/otpScreen.dart';
// import 'package:e_consular_card/screens/widgets/date_time_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // bool editable = true;

// class Enteryourdetails2 extends StatelessWidget {
//   const Enteryourdetails2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             appBar(),
//             const SizedBox(height: 20),
//             backIcon(),
//             //SizedBox(height: 30,),
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: const Column(
//                 children: [
//                   Text(
//                     "Almost there, Complete your profile",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Great, your account is almost ready, provide\nthe following details",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20,),
//                   EnterDetailsForm2()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EnterDetailsForm2 extends StatefulWidget {
//   const EnterDetailsForm2({super.key});

//   @override
//   State<EnterDetailsForm2> createState() => _EnterDetailsForm2State();
// }

// class _EnterDetailsForm2State extends State<EnterDetailsForm2> {
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
// var ap = Provider.of<AppProvider>(context);
//     var undp = Provider.of<UpdateNinDataProvider>(context,);
//     return Container(
//       child: Form(
//         key: _formkey,
//         child: Column(
//           //crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             textFieldForForm(
//                 "Address of Residence", "Enter your address", "Required",undp.residenceAddressLine1Controller,ap.editableField || undp.residenceAddressLine1Controller.text.isEmpty),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Phone Number", "Enter your Phone Number", "Required",undp.telephonenoController,ap.editableField),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("State of Residence",
//                 "Enter your state of residence", "Required",undp.residenceStateController,ap.editableField),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(
//               thickness: 1,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const DatePickerExample(),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm(
//                 "Address in Nigeria", "Enter your address", "Required",undp.originAddressLine1Controller,ap.editableField || undp.originAddressLine1Controller.text.isEmpty),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Country of Residence",
//                 "Enter your country of residence", "Required",undp.birthcountryController,ap.editableField || undp.birthcountryController.text.isEmpty ),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm(
//                 "Means of Identification", "Select ID type", "Required",undp.meansOfIDController,false),
//              const SizedBox(
//               height: 30,
//             ),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Validate returns true if the form is valid, or false otherwise.
//                  if (_formkey.currentState?.validate() == true) {
//                     // Save the form values
//                     _formkey.currentState?.save();

//                     // Process the data (e.g., send to a server, display in UI)
//                     // print('Name: $_name');
//                     // print('Email: $_email');

//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const NextOfKinInformation()));

//                     // You can display a success message using a Snackbar
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   SnackBar(content: Text('Form successfully submitted!')),
//                     // );
//                  }
//                 },
//                 style: ButtonStyle(
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                       Colors.green,
//                     ),
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                       Colors.white,
//                     )),
//                 child: const Text(
//                   "Continue",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//              const SizedBox(
//                     height: 50,
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
