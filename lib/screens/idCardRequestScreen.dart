import 'package:e_document_request/screens/cardDetails.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:e_document_request/screens/payWithCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IdCardRequestScreen extends StatelessWidget {
  const IdCardRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            backAppbar(),
            SizedBox(
              height: 60.h,
            ),
            idCardRequestScreenBody(context),
            SizedBox(
              height: 350.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: RegularGreenButton(context, "Pay with Paystack", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PayWithCard()));
              }),
            ),
            //SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}

Widget idCardRequestScreenBody(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 28.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ID Card Request",
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 45.h,
        ),
        Text(
          "Cost Price",
          style: TextStyle(color: Colors.grey, fontSize: 17.sp),
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          "\$100.00",
          style: TextStyle(
              color: Color(0xFF24985B),
              fontWeight: FontWeight.w800,
              fontSize: 25.sp),
        ),
        SizedBox(
          height: 28.h,
        ),
        Text(
          "Your card will be processed. Pay for your document authentication to proceed",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp),
        ),
      ],
    ),
  );
}

Widget RegularGreenButton(
    BuildContext context, String text, Function() onPressed) {
  return Container(
    width: double.infinity,
    height: 56.h,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF24985B),
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(5.r))),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

// Widget PayWithCard() {
//   return Container(
//     child: Column(
//       children: [
//         Text(
//           "Pay with Card",
//           style: TextStyle(fontWeight: FontWeight.w700),
//
//         ),
//         SizedBox(height: 30,),
//         CardDetailsForm(context)
//       ],
//     ),
//   );
// }
