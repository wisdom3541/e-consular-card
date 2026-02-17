// import 'package:e_consular_card/models/register_without_nin_response.dart';
// import 'package:e_consular_card/providers/app_provider.dart';
// import 'package:e_consular_card/providers/create_acccount_with_nin_provider.dart';
// import 'package:e_consular_card/providers/register_without_nin_provider.dart';
// import 'package:e_consular_card/providers/update_nin_data_provider.dart';
// import 'package:e_consular_card/screens/accountCreatedSuccessfully.dart';
// import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
// import 'package:e_consular_card/screens/createAccountWithNIN.dart';
// import 'package:e_consular_card/screens/enterYourDetails.dart';
// import 'package:e_consular_card/screens/otpScreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //bool editable = true;

// class NextOfKinInformation extends StatelessWidget {
//   const NextOfKinInformation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             appBar(),
//             const SizedBox(
//               height: 30,
//             ),
//             backIcon(),
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: const Column(
//                 children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Last step, Next off Kin Information",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Great, your account is almost ready, provide\nthe following details",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   NextofkininformationForm()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NextofkininformationForm extends StatefulWidget {
//   const NextofkininformationForm({super.key});

//   @override
//   State<NextofkininformationForm> createState() =>
//       _NextofkininformationFormState();
// }

// class _NextofkininformationFormState extends State<NextofkininformationForm> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     var ap = Provider.of<AppProvider>(context);
//     var undp = Provider.of<UpdateNinDataProvider>(context);
//     var rwnp = Provider.of<RegisterWithoutNinProvider>(context);
//     var cawnp = Provider.of<CreateAcccountWithNinProvider>(context);
//     return Container(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           //crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             textFieldForForm("First Name*", "Enter their first name",
//                 "Required", undp.nokFirstnameController, ap.editableField),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Last Name*", "Enter their last name", "Required",
//                 undp.nokSurnameController, ap.editableField),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Middle Name", "Enter their middle name",
//                 "Optional", undp.nokMiddlenameController, ap.editableField),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Phone Number", "080-xxx-xxxx", "Required",
//                 undp.nokTelephonenoController, ap.editableField || undp.nokTelephonenoController.text.isEmpty),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm(
//                 "Address of Residence",
//                 "Enter your next of kin address",
//                 "Required",
//                 undp.nokAddress1Controller,
//                 ap.editableField|| undp.nokAddress1Controller.text.isEmpty),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Relationship", "Mother", "Required",
//                 undp.nokRelationshipController, ap.editableField || undp.nokRelationshipController.text.isEmpty),
//             const SizedBox(
//               height: 20,
//             ),
//             textFieldForForm("Email*", "Enter their email", "Required",
//                 undp.nokEmailController, ap.editableField || undp.nokEmailController.text.isEmpty),
//             const SizedBox(
//               height: 50,
//             ),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   // Validate returns true if the form is valid, or false otherwise.
//                   if (_formKey.currentState?.validate() == true) {
//                     // Save the form values
//                     _formKey.currentState?.save();
//                     showLoadingSpinner(context);
//                     if(ap.ninRegisteration){
//                       await ap.updateWithNin(
//                         undp.createModelFromControllers(
//                             cawnp.userData!.hashedId),
//                         undp.passportImage!);

//                             Navigator.of(context, rootNavigator: true).pop();

//                                Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Accountcreatedsuccessfully()),
//                     (Route<dynamic> route) =>
//                         false, // Remove all previous routes
//                   );

//                     } else{

//                      var result = await RegisterWithoutNinProvider().updateWithoutNIn(undp.withoutNinDataFromControllers(rwnp.registerWithoutNinResponse!.data.hashedId),undp.passportImage!);

//                         Navigator.of(context, rootNavigator: true).pop();


//                     if(result){
//                        Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Accountcreatedsuccessfully()),
//                     (Route<dynamic> route) =>
//                         false, // Remove all previous routes
//                   );

//                     }

                   
//                     }
                    
                

//                     // Navigator.pushAndRemoveUntil(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //       builder: (context) => Accountcreatedsuccessfully()),
//                     //   (Route<dynamic> route) =>
//                     //       false, // Remove all previous routes
//                     // );

//                     // Process the data (e.g., send to a server, display in UI)
//                     //  print('Name: $_name');
//                     // print('Email: $_email');

//                     // You can display a success message using a Snackbar
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   SnackBar(content: Text('Form successfully submitted!')),
//                     // );
//                   } else {
//                     print("error updating data");
//                   }
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
//             const SizedBox(
//               height: 50,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
