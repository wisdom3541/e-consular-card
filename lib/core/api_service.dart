import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/auth_response.dart';
import 'package:e_document_request/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiService {
  Future<String?> grantAuth(BuildContext context) async {
    var appProvider = Provider.of<AppProvider>(context, listen: false);

    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(
          {"email": "toluwalopemi.shogade@gmail.com", "password": "password"});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final authData = AuthResponse.fromJson(response.data);
        if (authData.errorCode == 0) {
          appProvider.updateAuthResponse(authData);
          return authData.token;
        } else {
          return "error";
        }
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
