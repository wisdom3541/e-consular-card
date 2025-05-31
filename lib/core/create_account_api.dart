import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/register_user.dart';
import 'package:e_document_request/providers/app_provider.dart';
import 'package:e_document_request/providers/create_acccount_with_nin_provider.dart';
import 'package:e_document_request/providers/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountApi {
  Future<String?> createAccountNin(
      BuildContext context, RegisterUser registerUser) async {
    var appProvider = Provider.of<AppProvider>(context, listen: false);
    var cawnp =
        Provider.of<CreateAcccountWithNinProvider>(context, listen: false);
        var op =  Provider.of<OtpProvider>(context, listen: false);
      
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': appProvider.token
      };
      var data = json.encode({
        "EmailAddress": registerUser.emailAddress,
        "nationalid": registerUser.nin,
        "UserPassword": registerUser.password
      });
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/register-with-nin',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final user = RegisterUserResponse.fromJson(response.data);
        cawnp.updateUserCreated(user);
        final userData = RegisterDataResponse.fromJson(response.data["data"]);
        cawnp.updateUserData(userData);
        print("user data?");
        print(userData.hashedId);
        op.updateOtp(user.otp);
        //print("repo");
        return (json.encode(response.data));
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