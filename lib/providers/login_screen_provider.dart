import 'package:e_document_request/core/user_login_api.dart';
import 'package:flutter/material.dart';

class LoginScreenProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String userLoggedInToken;

  @override
  void dispose() {
    // TODO: implement dispose
   // emailController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

    void updateUserLoggedInToken(String token){
      userLoggedInToken = token;
      notifyListeners();
  }

  Future<void> login(String email, String password) async{
    var response = await UserLoginApi().userLogin(email, password);
    updateUserLoggedInToken(response!.token);
    
    print("REPONSE: $userLoggedInToken");
    notifyListeners();
  }
}