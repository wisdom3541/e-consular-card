import 'dart:async';
import 'dart:ffi';

import 'package:e_document_request/screens/accountCreatedSuccessfully.dart';
import 'package:e_document_request/screens/createAccount.dart';
import 'package:e_document_request/screens/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Createaccountwithnin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<CreateAccountWithNINAppState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            appBar(),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              "Enter Your NIN/Passport Number",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Get your account ready to get any\nconfidential document you need to.",
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  formField(context),
                  const SizedBox(
                    height: 30.0,
                  ),
                  formFieldText(context, TextInputType.number),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dial *510*1# to get your NIN",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: appState.nameVisibility,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Color.fromRGBO(223, 245, 239, 100),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: const Text(
                        "Dannon Groups",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 152, 91, 100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  createAccountButton(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateAccountWithNINAppState extends ChangeNotifier {
   final TextEditingController _controller = TextEditingController();
  String createAccountOption = "National Identity Number";
  String buttonValue = "Create Account.";
  bool nameVisibility = false;
  bool nameRetrieved = false;


  void updateCreateAccountDropdownOption(String value) {
    print(value.toString());
    createAccountOption = value;
    notifyListeners();
  }

  void createAccountButtonOnClick() {
    buttonValue = " Fetching Information...";
    notifyListeners();

    Timer(const Duration(milliseconds: 3000), () {
      nameVisibility = true;
      updateName();
      buttonValue = "Create Account.";
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    notifyListeners();
  }

  void createAccountFinalOnClick(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OtpScreen(otpType: "Enter OTP sent to your number", otpMessage: "We sent an OTP to the number linked to your\nNIN, Kindly use it to verify and continue", nextPage: Accountcreatedsuccessfully(),)));
    notifyListeners();
  }

  void updateName(){
    nameRetrieved = true;
    notifyListeners();
  }


  void createAccountButtonSelect( BuildContext context){
    if(nameRetrieved){
      createAccountFinalOnClick(context);
      notifyListeners();
    }else{
      createAccountButtonOnClick();
      notifyListeners();
    }
  }
}

Widget formField(BuildContext context) {
  var appState = Provider.of<CreateAccountWithNINAppState>(context);
  var dropDownOption = appState.createAccountOption;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Choose Identification Type",
        style: TextStyle(color: Colors.black, fontSize: 14.0),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          //style: TextStyle(fontWeight: FontWeight.w400),
          underline: const SizedBox.shrink(),
          isExpanded: true,
          // Expands the dropdown to full width
          value: appState.createAccountOption,
          // Currently selected value
          items: <String>[
            'National Identity Number',
            'Passport Number',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            appState.updateCreateAccountDropdownOption(newValue!);
          },
        ),
      ),
    ],
  );
}

Widget formFieldText(BuildContext context, TextInputType textInputType) {
  var appState = Provider.of<CreateAccountWithNINAppState>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Enter Number"),
      TextField(
        onSubmitted: (String value){

        },
        controller: appState._controller,
        keyboardType: TextInputType.number,
        maxLength: 10,
        decoration: InputDecoration(
            hintText: "0123456789",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      )
    ],
  );
}

Widget createAccountButton(BuildContext context) {
  var appState = Provider.of<CreateAccountWithNINAppState>(context);
  return Container(
    width: double.infinity,
    height: 50,
    child: FilledButton(
      onPressed: () {
        appState.createAccountButtonSelect(context);
      },
      child: Text(
        appState.buttonValue,
        style: TextStyle(color: Colors.white),
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
