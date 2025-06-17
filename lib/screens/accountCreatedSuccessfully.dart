import 'package:e_document_request/providers/loggedIn/dashboard_provider.dart';
import 'package:e_document_request/providers/login_screen_provider.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/loginScreen.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accountcreatedsuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBar(),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                backIcon(),
                // Image.asset(name),
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.cloud_done_rounded,
                  size: 150,
                  fill: 1,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Your account has been created",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your details will be imported from NIMC and\nthat will be used to generate profile.",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                continueButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget continueButton(BuildContext context) {
  var dashboardProvider = Provider.of<DashboardProvider>(context,listen: false);
  var loginProvider = Provider.of<LoginScreenProvider>(context,listen: false);
  return Container(
    width: double.infinity,
    height: 50,
    child: FilledButton(
      onPressed: () async {
        //showLoadingSpinner(context);
        //await dashboardProvider.getAllDashboardData(loginProvider.userLoggedInToken);
        //Navigator.of(context).pop();
         Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
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
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
