import 'package:e_document_request/screens/cardDetails.dart';
import 'package:e_document_request/screens/idCardRequestScreen.dart';
import 'package:e_document_request/screens/paymentSucessful.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PayWithCard extends StatelessWidget {
  const PayWithCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            backAppbar(),
            idCardRequestScreenBody(context),
            //SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Pay with Card",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  cardDetailsForm(context),
                  RegularGreenButton(context, "Proceed to Pay.", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentSucessful()));
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

Widget cardDetailsForm(BuildContext context) {
  return Container(
    child: Column(
      children: [
        CardInputTextField(context, "Email", "docRequest@gmail.com",
            TextInputType.emailAddress),
        SizedBox(
          height: 15,
        ),
        CardInputTextField(context, "Card Number", "xxxx xxxx xxxx xxxx",
            TextInputType.number),
        SizedBox(
          height: 15,
        ),
        DateAndCvv(context),
        SizedBox(height: 15,),
        CardInputTextFieldNotEditable(
            context, "Name on Card", "Card Holder Name", TextInputType.text),
        SizedBox(
          height: 30.h,
        ),
      ],
    ),
  );
}

Widget DateAndCvv(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: CardInputTextField(
            context, "Expiry Date", "MM/YY", TextInputType.text),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
          child:
              CardInputTextField(context, "CVV", "XXX", TextInputType.number))
    ],
  );
}

Widget CardInputTextField(BuildContext context, String title, String hintText,
    TextInputType inputType) {
  var appState = Provider.of<PayWithCardState>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      TextField(
        onSubmitted: (String value) {},
        controller: appState._controller,
        keyboardType: inputType,
        //maxLength: 10,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      )
    ],
  );
}

Widget CardInputTextFieldNotEditable(BuildContext context, String title,
    String hintText, TextInputType inputType) {
  var appState = Provider.of<PayWithCardState>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      TextField(
        enabled: false,
        onSubmitted: (String value) {},
        controller: appState._controller,
        keyboardType: inputType,
        //maxLength: 10,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      )
    ],
  );
}

class PayWithCardState extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
}
