import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/core/cart/data/cart_response.dart';

class AllCartApi {
  Future<CartResponse?> getAllCartItems(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/carts',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        var cartResponse = CartResponse.fromJson(response.data);
        if(cartResponse.success){
          return cartResponse;
        }else{
          return null;
        }
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

  Future<ClearCartResponse?> clearCart(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token'
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
        //   return "Connection failed: ${e.message}";
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      //  return "Unexpected error occurred";
    }
    return null;
  }
}
