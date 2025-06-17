import 'package:e_document_request/core/user_login_api.dart';
import 'package:flutter/material.dart';

class LoginScreenProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   String userLoggedInToken = "";

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

Future<bool> login(String email, String password) async {
  try {
    var response = await UserLoginApi().userLogin(email, password);

    if (response != null && response.token != null) {
      updateUserLoggedInToken(response.token!);
      print("RESPONSE: $userLoggedInToken");
      notifyListeners();
      return true;
    } else {
      print("Login failed: ${response?.error ?? 'Unknown error'}");
      return false;
      // Optionally, you can show a toast/snackbar/dialog here
    }
  } catch (e) {
    print("Login error: $e");
    return false;
    // Optionally: show a user-friendly error here too
  }
}

}