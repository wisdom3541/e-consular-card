// import 'package:e_consular_card/providers/app_provider.dart';
// import 'package:e_consular_card/providers/create_acccount_with_nin_provider.dart';
// import 'package:e_consular_card/features/auth/presentation/screens/createAccount.dart';
// import 'package:e_consular_card/screens/createAccountWithNIN.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class VerifyNin extends StatelessWidget {
//   const VerifyNin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var appState = Provider.of<AppProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             appBar(),
//             SizedBox(
//               height: 50.h,
//             ),
//             Text(
//               "Enter Your NIN/Passport Number",
//               style: TextStyle(
//                   fontSize: 20.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Text(
//               "Get your account ready to get any\nconfidential document you need to.",
//               style: TextStyle(fontSize: 13.sp, color: Colors.grey),
//             ),
//             SizedBox(
//               height: 50.h,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   formField(context),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   formFieldText(context, TextInputType.number),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Dial *510*1# to get your NIN",
//                         style: TextStyle(color: Colors.grey, fontSize: 13.sp),
//                       )),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const SizedBox(
//                     height: 50.0,
//                   ),
//                   createAccountButton(context)
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget formField(BuildContext context) {
//   var appState = Provider.of<AppProvider>(context);
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Choose Identification Type",
//         style: TextStyle(color: Colors.black, fontSize: 14.0),
//       ),
//       const SizedBox(
//         height: 5,
//       ),
//       Container(
//         constraints: BoxConstraints(minWidth: double.infinity),
//         decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Colors.grey,
//             ),
//             borderRadius: BorderRadius.circular(10)),
//         child: DropdownButton<String>(
//           //style: TextStyle(fontWeight: FontWeight.w400),
//           underline: const SizedBox.shrink(),
//           isExpanded: true,
//           // Expands the dropdown to full width
//           value: 'National Identity Number',
//           // Currently selected value
//           items: <String>['National Identity Number']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   value,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             // appState.updateCreateAccountDropdownOption(newValue!);
//           },
//         ),
//       ),
//     ],
//   );
// }

// Widget formFieldText(BuildContext context, TextInputType textInputType) {
//   var appState = Provider.of<AppProvider>(context);
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text("Enter NIN Number"),
//       SizedBox(
//         height: 5.h,
//       ),
//       TextField(
//         onSubmitted: (String value) {},
//         controller: appState.ninController,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly, // Only allows 0–9
//         ],
//         keyboardType: TextInputType.number,
//         maxLength: 11,
//         decoration: const InputDecoration(
//             hintText: "0123456789",
//             hintStyle: TextStyle(color: Colors.grey),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)))),
//       )
//     ],
//   );
// }

// Widget createAccountButton(BuildContext context) {
//   var appState = Provider.of<AppProvider>(context);
//   var cawnp = Provider.of<CreateAcccountWithNinProvider>(context);
//   var ninController = appState.ninController;
//   return Container(
//     width: double.infinity,
//     height: 50,
//     child: FilledButton(
//       onPressed: () async {
//         if (ninController.text.isEmpty ||
//             ninController.text == "" ||
//             ninController.text.length != 11) {
//           print("error");
//           Fluttertoast.showToast(
//             msg: "Please enter your NIN",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             backgroundColor: Colors.black87,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//         } else {
//           showLoadingSpinner(context);
//           await appState.verifyNin(context);
//           appState.updateNin(ninController.text);
//           Navigator.of(context).pop();
//           cawnp.updateNin(ninController.text);
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const CreateAccountWithNIN()),
//             (Route<dynamic> route) => false, // Remove all previous routes
//           );
//         }
//       },
//       style: ButtonStyle(
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//           backgroundColor: MaterialStateProperty.all<Color>(
//             Colors.green,
//           ),
//           foregroundColor: MaterialStateProperty.all<Color>(
//             Colors.white,
//           )),
//       child: const Text(
//         "Continue",
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//   );
// }
