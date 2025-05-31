import 'package:e_document_request/core/dashboard_call_api.dart';
import 'package:e_document_request/models/document/document_response.dart';
import 'package:e_document_request/models/userResponse/citizen.dart';
import 'package:e_document_request/models/userResponse/citizen_response.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {

  late CitizenResponse citizenResponse;
  late Citizen citizenData;
  late DocumentResponse documentResponse;
  late List<Document> document;

  void updateCitizenResponse( CitizenResponse obj){
    citizenResponse = obj ;
    notifyListeners();
  }

  void updateCitizenData( Citizen obj){
    citizenData = obj ;
    notifyListeners();
  }

    void updateDocumentResponse( DocumentResponse documentResponse, List<Document> document){
    this.documentResponse = documentResponse ;
    this.document = document;
    notifyListeners();
  }

  Future<void> getAllDashboardData(String token) async{
    var cr = await DashboardCallApi().getDashboardData(token);
    updateCitizenResponse(cr!);
    print(cr.fullName);
    updateCitizenData(cr.citizen);
    print(citizenData.firstName);
    var document = await DashboardCallApi().getDocument(token);
    updateDocumentResponse(document!, document.documents);
    print(document.country);
    await DashboardCallApi().getPayment(token);
    notifyListeners();
  }

}