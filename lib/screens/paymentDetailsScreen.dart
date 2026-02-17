// import 'package:e_consular_card/screens/cartScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PaymentDetailsScreen extends StatelessWidget {
//   const PaymentDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 28.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               onScreenBackButton(),
//               SizedBox(
//                 height: 50,
//               ),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Transaction Information",
//                     style: TextStyle(color: Colors.grey, fontSize: 18),
//                   ),
//                   Text(
//                     "Paid",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff1a6c41),
//                         fontSize: 18),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               transactionDetails("Payment ID", "PM0000011", Colors.black),
//               transactionDetails(
//                   "Transaction Type", "Card - Paystack", Colors.black),
//               transactionDetails("Response Code", "00", Colors.black),
//               transactionDetails("Amounts", "₦ 21,000", Colors.black),
//               transactionDetails(
//                   "Date", "22, Jan, 2021 @ 4:34PM", Colors.black),
//               transactionDetails("RRN", "2928387477400", Colors.black),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Attached Documents",
//                 style: TextStyle(color: Color(0xff1a6c41), fontSize: 16),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               document(),
//               SizedBox(
//                 height: 20,
//               ),
//               document(),
//               SizedBox(
//                 height: 50,
//               ),
//               buttonTemplate(context, "Download Receipt", Color(0xFF24985B),
//                   Colors.white, () {}),
//               SizedBox(
//                 height: 10,
//               ),
//               buttonTemplate(context, "View Account", Color(0xffE9F5EF),
//                   Color(0xFF24985B), () {}),
//               SizedBox(
//                 height: 70,
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// Widget document() {
//   return Container(
//     color: Color(0xffFAFAFA),
//     child: Row(
//       children: [
//         Icon(
//           Icons.file_present_rounded,
//           size: 20,
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         Text(
//           "#DC-009",
//           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//         )
//       ],
//     ),
//   );
// }

// Widget transactionDetails(String title, String value, Color valueTextColor) {
//   return Container(
//     child: Column(
//       children: [
//         SizedBox(
//           height: 15,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(color: Colors.grey, fontSize: 18),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: valueTextColor,
//                   fontSize: 18),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Divider()
//       ],
//     ),
//   );
// }

// Widget buttonTemplate(BuildContext context, String text, Color backGroundColor,
//     Color textColor, Function() onPressed) {
//   return Container(
//     width: double.infinity,
//     height: 56.h,
//     child: TextButton(
//       style: TextButton.styleFrom(
//           backgroundColor: backGroundColor,
//           shape: RoundedRectangleBorder(
//               side: const BorderSide(color: Colors.transparent, width: 0),
//               borderRadius: BorderRadius.circular(5.r))),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
//       ),
//     ),
//   );
// }

// //
// // Widget transactionInfo(){
// //   return Container(
// //     child: Row(
// //       children: [
// //
// //       ],
// //     ),
// //   );
// // }
