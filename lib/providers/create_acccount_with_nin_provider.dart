import 'dart:async';

import 'package:e_document_request/core/api_service.dart';
import 'package:e_document_request/core/create_account_api.dart';
import 'package:e_document_request/models/register_user.dart';
import 'package:e_document_request/providers/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAcccountWithNinProvider extends ChangeNotifier {
  final TextEditingController ninController = TextEditingController();
  late RegisterUserResponse userCreated ;
   RegisterDataResponse? userData ;
  


  @override
  void dispose() {
   // controller.dispose();
    super.dispose();
    notifyListeners();
  }

  Future<bool> createAccountOnClick(BuildContext context,RegisterUser registerUser ) async {

    var result = await CreateAccountApi().createAccountNin(context, registerUser);
    print("result $result");
    notifyListeners();
    return true;
  }

  void updateNin(String val){
    ninController.text = val;
    notifyListeners();
  }

void updateUserCreated(RegisterUserResponse val) {
    userCreated = val;
    print(userCreated.otp);
    notifyListeners();
  }

  
void updateUserData(RegisterDataResponse val) {
    userData = val;
    print("from user data:?? ${userData?.hashedId}");
    notifyListeners();
  }


  // void createAccountButtonSelect(BuildContext context) {
  //   // if(nameRetrieved){
  //   createAccountFinalOnClick(context);
  //   notifyListeners();
  //   // }else{
  //   //   createAccountButtonOnClick();
  //   //   notifyListeners();
  //   // }
  // }

 }

