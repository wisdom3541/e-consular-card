import 'dart:ffi';

import 'package:e_document_request/core/api_service.dart';
import 'package:e_document_request/screens/createAccountWithNIN.dart';
import 'package:e_document_request/screens/createAccountWithoutNIN.dart';
import 'package:e_document_request/screens/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appBar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Text(
                "Welcome to iDocRequest.\nCreate an account",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Get your account ready to get any confidential document you need to.",
                style: TextStyle(
                    fontSize: 19.sp, color: Colors.grey, fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    accountCreationMethodButton(
                        "Register with your NIN,\nRequest for a card quicker",
                        Color(0xff24985B),
                        Colors.white,
                        Colors.white,  () {
                      ApiService().grantAuth(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccountWithNIN()));
                    }),
                    SizedBox(height: 27.h),
                    accountCreationMethodButton(
                        "Manual Registration, Card request may take longer.",
                        Color(0xffE9F5EF),
                        Colors.grey,
                        Colors.black, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountWithoutNIN()));
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              alreadyHaveAccount(context),
            ],
          )
        ],
      ),
    );
  }
}

Widget accountCreationMethodButton(String regMethodText, Color backgroundColor,
    Color textColor, Color iconColor, void Function() Function) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
    ),
    onPressed: Function,
    child: SizedBox(
      height: 110.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //"Register with your NIN or Passport Number, Request for a card quicker"
          Expanded(
            child: Text(
              regMethodText,
              style: TextStyle(fontSize: 18.sp, color: textColor),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.navigate_next,
                color: iconColor,
              ))
        ],
      ),
    ),
  );
}

Widget alreadyHaveAccount(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    },
    child: Wrap(
      children: [
        Text("Already have an account? ",
            style: TextStyle(fontSize: 15.0, color: Colors.grey)),
        Text(
          "Log in",
          style: TextStyle(color: Color(0xff24985B), fontSize: 15.0),
        )
      ],
    ),
  );
}

Widget appBar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    height: 78.h,
    color: const Color(0xff1a6c41),
    // color: const Color.fro(26, 108, 65, 100),
    //Color.fromRGBO(20, 84, 50, 100),
    alignment: Alignment.centerLeft,
    child: Text(
      "IDOCREQUEST",
      style: TextStyle(
          fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
    ),
  );
}
