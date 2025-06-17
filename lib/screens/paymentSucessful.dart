import 'package:e_document_request/screens/cardDetails.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentSucessful extends StatelessWidget {
  const PaymentSucessful({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<HomePageState>(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          backAppbar(),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: const Icon(
                    size: 100,
                    Icons.check_circle_outline_rounded,
                    color: Color(0xFF24985B),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your payment was successful",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your receipt and other details have been sent to your email. Kindly send a report if you didn’t make this transaction.",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  height: 100,
                ),
                RegularGreenButton(context, "Continue", () {
                  appState.updateSelectedIndex(1);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}
