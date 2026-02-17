import 'dart:typed_data';

import 'package:e_consular_card/core/dashboard_call_api.dart';
import 'package:e_consular_card/core/get_user_passport.dart';
import 'package:e_consular_card/models/document/document_response.dart';
import 'package:e_consular_card/models/userResponse/citizen.dart';
import 'package:e_consular_card/models/userResponse/citizen_response.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  late CitizenResponse citizenResponse;
  late Citizen citizenData;
  late DocumentResponse documentResponse;
  late List<Document> document;

  // Store passport image
  Uint8List? passportImage;

  void updateCitizenResponse(CitizenResponse obj) {
    citizenResponse = obj;
    notifyListeners();
  }

  void updateCitizenData(Citizen obj) {
    citizenData = obj;
    notifyListeners();
  }

  void updateDocumentResponse(
      DocumentResponse documentResponse, List<Document> document) {
    this.documentResponse = documentResponse;
    this.document = document;
    notifyListeners();
  }

  Future<void> getAllDashboardData(String token) async {
    var cr = await DashboardCallApi().getDashboardData(token);
    if (cr == null) {
      print("Dashboard data is null — maybe token expired or server error.");
      return; // or show error dialog/snackbar
    }
    updateCitizenResponse(cr);
    print(cr.fullName);
    updateCitizenData(cr.citizen);
    print(citizenData.firstName);
    setPassportImage();
    var document = await DashboardCallApi().getDocument(token);
    updateDocumentResponse(document!, document.documents);
    print(document.country);
    //await DashboardCallApi().getPayment(token);
    notifyListeners();
  }

  Future<Uint8List?> getPassport(String citizenId) {
    var response = GetUserPassport().getPassport(citizenId);
    
    return response;
  }

  Future<void> setPassportImage() async {
    passportImage = await getPassport(citizenData.citizenId);
    
    notifyListeners();
  }
}
