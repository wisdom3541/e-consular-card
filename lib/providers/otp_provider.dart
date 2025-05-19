import 'package:e_document_request/core/registeration_data_api.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  int? otp = 0;
  final TextEditingController otpController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
   // otpController.dispose();
    super.dispose();
  }

  void updateOtp(int? val) {
    otp = val;
    notifyListeners();
  }


   void getUserRegisterationdetails(String hashId) async {
    var data = await RegisterationDataApi().getUserRegisterationdetails(hashId);
    print(data.toString());
    notifyListeners();
   }
}
