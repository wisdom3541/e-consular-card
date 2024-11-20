import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyRequestScreen extends StatelessWidget {
  const EmptyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      body: Column(

        children: [
          appBar(),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homePageWidget(context),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/docImg.png",
                    // height: 100,
                    // width: 100,
                  ),
                ),
                Text(
                  "You currently don’t have any pending or processed documents. You can request for one now",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    //width: double.infinity,
                    height: 36.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFF24985B),
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(5.r))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      },
                      child: Text(
                        "Request New Document",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}


Widget homePageWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 20,
      ),
      const Wrap(children: [
        Text(
          "Welcome, ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          "John",
          style: TextStyle(
              color: Color(0xff24985B),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        )
      ]),
      const SizedBox(
        height: 20,
      ),
      filterWidgetBar(context),
      SizedBox(
        height: 20,
      ),
      searchBar(),
      SizedBox(
        height: 20,
      ),
      Align(alignment: Alignment.center, child: filterButton()),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
