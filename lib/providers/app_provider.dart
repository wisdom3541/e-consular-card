// import 'dart:io';

// import 'package:e_consular_card/core/update_with_nin_api.dart';
// import 'package:e_consular_card/core/verify_nin_api.dart';
// import 'package:e_consular_card/models/auth_response.dart';
// import 'package:e_consular_card/models/update_with_nin.dart';
// import 'package:e_consular_card/screens/loginScreen.dart';
// import 'package:flutter/material.dart';

// class AppProvider extends ChangeNotifier {
//   bool ninRegisteration = false;
//   bool editableField = true;
//  //  it's a proper getter —
//   //bool get isBirthCertImageRequired => !ninRegisteration;

//   String token = "" ;
//   TextEditingController ninController = TextEditingController();
//   String nin = "" ; // nin in verify and passed to create acccount
//   late AuthResponse response;
//   late UpdateWithNin data;

//   void reset() {
//     ninController.clear();
//     notifyListeners(); // if your UI depends on controller value
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     reset();
//     ninController.dispose();
//     super.dispose();
//   }

//   void setNinRegistrationType(bool val) {
//     ninRegisteration = val;
//     editableField = !val;
//     notifyListeners();
//   }

 

//   void setToken(String val) {
//     token = val;
//     print("this is token $token");
//     notifyListeners();
//   }

//   void updateNin(String nin) {
//     print("updating NIN $nin");
//     this.nin = nin;
//     notifyListeners();
//   }

//   void updateAuthResponse(AuthResponse val) {
//     response = val;
//     setToken(response.token);
//     print(response.token);
//     notifyListeners();
//   }

//   Future<void> verifyNin(BuildContext context) async {
//     print("verifying NIN");
//     bool? reponse =
//         await VerifyNinApi().verifyNinApi(context, ninController.text);

//     if (reponse == null) {
//       print("null");
//     } else {
//       if(!reponse){
//           showSnackBar(context, "This NIN has been registered. Please Log IN");
//       }
//     }
//     notifyListeners();
//   }

//   Future<void> updateWithNin(
//       UpdateWithNin updateWithNin, File passportFile) async {
//     var reponse =
//         await UpdateWithNinApi().updateNinData(updateWithNin, passportFile);
//     print(reponse);
//     notifyListeners();
//   }
// }
