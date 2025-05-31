import 'package:e_document_request/core/update_with_nin_api.dart';
import 'package:e_document_request/core/verify_nin_api.dart';
import 'package:e_document_request/models/auth_response.dart';
import 'package:e_document_request/models/update_with_nin.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String token = "";
  TextEditingController ninController = TextEditingController();
  String nin = ""; // nin in verify and passed to create acccount
  late AuthResponse response;
  late UpdateWithNin data;


  @override
  void dispose() {
    // TODO: implement dispose
    ninController.dispose();
    super.dispose();
  }

  void setToken(String val) {
    token = val;
    print("this is token $token");
    notifyListeners();
  }

  void updateNin(String nin){
    print("updating NIN $nin");
    this.nin= nin;
    notifyListeners();
  }

  void updateAuthResponse(AuthResponse val) {
    response = val;
    setToken(response.token);
    print(response.token);
    notifyListeners();
  }

  Future<void> verifyNin(BuildContext context) async {
    print("verifying NIN");
    var reponse = await VerifyNinApi().verifyNinApi(context, ninController.text);
    if(reponse == null){
      print("null");
    }else{
    print(reponse);
    }
    notifyListeners();
  }

  Future<void> updateWithNin(UpdateWithNin updateWithNin) async {
    var reponse = await UpdateWithNinApi().updateNinData(updateWithNin);
    print(reponse);
    notifyListeners();

  }
}
