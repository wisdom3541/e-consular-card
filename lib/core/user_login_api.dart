import 'dart:convert';

import 'package:dio/dio.dart';

class UserLoginApi {
  Future<dynamic> userLogin(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(
          {"email": email, "password": password});
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
  }
}
