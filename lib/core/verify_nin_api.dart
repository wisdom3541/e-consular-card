import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/citizen_data.dart';
import 'package:e_document_request/providers/app_provider.dart';
import 'package:e_document_request/providers/update_nin_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyNinApi {



  Future<String?> verifyNinApi(BuildContext context, String nin) async {
    var vnp = Provider.of<UpdateNinDataProvider>(context,listen: false);
    var appProvider = Provider.of<AppProvider>(context,listen: false);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization':
            appProvider.token
      };
      var url = 'https://api.e-docrequest.com/api/verify-nin/$nin';
      print(url);
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(url
        ,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("API Raw Data: ${response.data["data"]}");

        final citizenData = CitizenData.fromJson(response.data["data"]);
       vnp.updateCitizenData(citizenData);
        print("update??");
        print(citizenData.firstname);
    //    vnp.populateRetrievedData();
        //print(json.encode(response.data).toString());
        return citizenData.firstname.toString();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with a status other than 200
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        return e.response?.data['message'] ?? "Server error occurred";
      } else {
        // There was a connection error (e.g., no internet)
        print('Connection error: ${e.message}');
        return "Connection failed: ${e.message}";
      }
    } catch (e, st) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      print("StackTrace: $st");
      return "Unexpected error occurred";
    }
    return null;
  }
}
