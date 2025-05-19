import 'package:e_document_request/models/auth_response.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String token = "";
  late AuthResponse response;

  void setToken(String val) {
    token = val;
    print("this is token $token");
    notifyListeners();
  }

  void updateResponse(AuthResponse val) {
    response = val;
    setToken(response.token);
    print(response.token);
    notifyListeners();
  }
}
