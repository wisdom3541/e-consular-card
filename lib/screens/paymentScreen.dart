import 'package:e_document_request/screens/homePage.dart';
import 'package:e_document_request/screens/paymentDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            homePageAppBar(icon),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Payments",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Keep track of all your payments in one place",
                    style: TextStyle(color: Colors.grey),
                  ),
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
                    height: 20,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return paymentListCard(context);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget paymentListCard(BuildContext context) {
  return Card(
    elevation: 10,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "# 0000001",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          statusAndTotalPayment(),
          SizedBox(
            height: 20,
          ),
          requestedDate(),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentDetailsScreen()));
              },
              child: Text(
                "Details",
                style: TextStyle(color: Color(0xff24985B)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget statusAndTotalPayment() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [status("Pending"), totalPayment()],
  );
}

Widget totalPayment() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Total Payment",
        style: TextStyle(color: Color(0xffA8A8A8)),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "156,000",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xff1470F9),
            fontSize: 20),
      )
    ],
  );
}
