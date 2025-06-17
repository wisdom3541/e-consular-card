import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/payment_verification_response.dart';

class VerifyPaymentApi {
  Future<PaymentVerificationResponse?> verifyOrderPayment(
      String token, String reference, String orderId) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data =
          json.encode({"transaction_id": reference, "order_id": orderId});
      print("This iis transaction id: $reference");
      print("This iis order id: $orderId");

      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/payment/callback',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return PaymentVerificationResponse.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with a status other than 200
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        // return e.response?.data['message'] ?? "Server error occurred";
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
