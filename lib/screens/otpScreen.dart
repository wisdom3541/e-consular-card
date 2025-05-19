import 'package:e_document_request/providers/create_acccount_with_nin_provider.dart';
import 'package:e_document_request/providers/otp_provider.dart';
import 'package:e_document_request/providers/verify_nin_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/enterYourDetails.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final String otpType;
  final String otpMessage;
  final dynamic nextPage;

  const OtpScreen({
    super.key,
    required this.otpType,
    required this.otpMessage,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    var op = Provider.of<OtpProvider>(context, listen: false);
    var cawnp = Provider.of<CreateAcccountWithNinProvider>(context);
    var vnp = Provider.of<VerifyNinProvider>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    var otp = "";

    Future<void> onSubmit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // You can now use the `otp` or `_otpController.text`
        print("Validated OTP: $otp");
        print("getting data");
        await vnp.getCitizenData(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Enteryourdetails()),
        );
        op.getUserRegisterationdetails(cawnp.userData.hashedId);
        // Call appState.getOtp(otp) or navigate next
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong OTP. Try Again')),
        );
        print("Invalid OTP");
      }
    }

    return Scaffold(
      body: Column(
        children: [
          appBar(),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                backIcon(),
                const SizedBox(height: 30),
                otpTypeText(otpType),
                const SizedBox(height: 20),
                Text(
                  otpMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),

                /// ✅ Wrap your field with a Form
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                   // controller: op.otpController,
                    length: 6,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (value) {
                      // if (value == null || value.length < 6 || value != op.otp.toString() ) {
                      //   return 'Enter the 6-digit OTP';
                      // }
                      return null;
                    },
                    onSaved: (value) => otp = value ?? '',
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.grey[100],
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.blue[200],
                      activeColor: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Didn’t receive the 6 digit code ? ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),

                /// Final Button
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text("Verify OTP"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
    child: const Row(
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
            context, MaterialPageRoute(builder: (context) => className));
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.green,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          )),
      child: const Text(
        "Continue",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
