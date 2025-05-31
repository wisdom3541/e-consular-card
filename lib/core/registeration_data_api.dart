import 'dart:convert';

import 'package:dio/dio.dart';

class RegisterationDataApi {
  Future<String?> getUserRegisterationdetails(String hashId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"id": hashId});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/register-with-nin-data',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with a status other than 200
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        var data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          return data['message'];
        } else if (data is String) {
          // If the server returned HTML or plain text (like a 500 error page)
          return "Server error: $data";
        } else {
          return "Unexpected server response.";
        }
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
