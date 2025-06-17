import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/core/cart/data/cart_response.dart';

class ClearCartApi {
  Future<ClearCartResponse?> clearCart() async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = json.encode({"document_id": "47-120-8441"});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/cart/clear',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return ClearCartResponse.fromJson(response.data);
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
      // return "Unexpected error occurred";
    }
    return null;
  }
}
