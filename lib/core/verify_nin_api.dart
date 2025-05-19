import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/citizen_data.dart';
import 'package:e_document_request/providers/app_provider.dart';
import 'package:e_document_request/providers/verify_nin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyNinApi {



  Future<String?> verifyNinApi(BuildContext context) async {
    var vnp = Provider.of<VerifyNinProvider>(context,listen: false);
    var appProvider = Provider.of<AppProvider>(context,listen: false);
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization':
            appProvider.token
      };
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/verify-nin/90123456789',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final citizenData = CitizenData.fromJson(response.data["data"]);
        vnp.updateCitizenData(citizenData);
        vnp.populateRetrievedData();
        print(json.encode(response.data));
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
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      return "Unexpected error occurred";
    }
    return null;
  }
}
