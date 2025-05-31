import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/login_response.dart';

class UserLoginApi {


  Future<LoginResponse?> userLogin(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data =
          json.encode({"email": "testdash@gmail.com", "password": "password"});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        final userLoggedInData = LoginResponse.fromJson(response.data);
        print(userLoggedInData.token);
        return userLoggedInData;

      } else {
        print(response.statusMessage);
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
        //return "Connection failed: ${e.message}";
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      //return "Unexpected error occurred";
    }
    return null;
  }
}
