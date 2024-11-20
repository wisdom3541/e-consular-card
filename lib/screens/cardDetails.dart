import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            backAppbar(),
            SizedBox(height: 79.h ,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      fit: BoxFit.fill,
                         width: double.infinity, "images/handcard.png"),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Get Your Card",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      "Nike operates retail stores worldwide,including Nike-branded retail outlets, factory stores, and concept stores....",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30 ,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [cardAmount(), cardExpires("2 Years")],
                    ),
                    SizedBox(height: 80,),
                    cancelAndRequestButton(context)
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

Widget backAppbar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 28.w),
    height: 70,
    color: const Color(0xff1a6c41),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Back",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        )
      ],
    ),
  );
}

Widget cancelAndRequestButton( BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                //backgroundColor: Color(0xFF24985B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),

        SizedBox(width: 20,),
        
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF24985B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> IdCardRequestScreen()));
            },
            child: Text(
              "Request Card",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
