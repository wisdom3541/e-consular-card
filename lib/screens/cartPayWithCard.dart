// import 'package:e_consular_card/screens/cartScreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:e_consular_card/screens/payWithCard.dart';

// class CartPayWithCard extends StatelessWidget {
//   const CartPayWithCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 28.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
//                 onScreenBackButton(),
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       const Text(
//                         "Cart Summary",
//                         style:
//                             TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Text(
//                         "Please Proceed With Payment",
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       //cartSummary(""),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         "Pay with Card",
//                         style:
//                             TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       cardDetailsForm(context),
//                       const SizedBox(height: 50,),
//                      // proceedButton(context),
//                       const SizedBox(height: 30,)
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
