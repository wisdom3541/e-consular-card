import 'dart:ffi';

import 'package:e_document_request/screens/accountCreatedSuccessfully.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final String otpType;
  final String otpMessage;
  final dynamic nextPage;

  const OtpScreen({super.key, required this.otpType, required this.otpMessage, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<OtpScreenState>(context);
    var ap = appState.nextPage(context);
    var otp = "12345";
    return Scaffold(
      body: Column(
        children: [
          appBar(),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                backIcon(),
                const SizedBox(
                  height: 30,
                ),
                otpTypeText(otpType),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  otpMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                PinCodeTextField(
                  // controller: appState._otpCodeController,
                  length: 5,
                  onChanged: (value) {
                    otp = value;
                    if (otp.length > 4) {
                      appState.getOtp(otp);
                    }
                  },
                  appContext: context,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.grey[100],
                    // Color for active fields
                    inactiveFillColor: Colors.white,
                    // Color for inactive fields
                    selectedFillColor: Colors.blue[200],
                    // Color for selected fieldsblue
                    activeColor: Colors.grey, // Border color for active field
                  ),
                  // Optionally, you can add error text, shape, and style
                ),
                const SizedBox(),
                const Text(
                  "Didn’t receive the 6 digit code ? ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),

                createAccountFinalButton(context, nextPage)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtpScreenState extends ChangeNotifier {
  late String otp;

  // final TextEditingController _otpCodeController = TextEditingController();

  @override
  void dispose() {
    //_otpCodeController.dispose();
    super.dispose();
  }

  void getOtp(String otpValue) {
    otp = otpValue;
    print(otp);
  }

  void nextPage(BuildContext context) {}
}

Widget otpTypeText(String otpType) {
  return Text(
    otpType,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  );
}

Widget backIcon() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Icon(
          Icons.arrow_back,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Back",
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
  );
}

Widget createAccountFinalButton(BuildContext context, dynamic className) {
  return Container(
    width: double.infinity,
    height: 50,
    child: FilledButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => className));
      },
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.green,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          )),
    ),
  );
}
