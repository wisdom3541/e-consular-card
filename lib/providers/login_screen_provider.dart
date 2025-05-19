import 'package:e_document_request/core/user_login_api.dart';
import 'package:flutter/material.dart';

class LoginScreenProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
   // emailController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

  void login() async{
    var response = UserLoginApi().userLogin(emailController.text, passwordController.text);
    print("REPONSE::");
    print(response.toString());
    notifyListeners();
  }
}