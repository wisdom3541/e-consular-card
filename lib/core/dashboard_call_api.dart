import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/document/document_response.dart';
import 'package:e_document_request/models/userResponse/citizen_response.dart';

class DashboardCallApi {

  Future<CitizenResponse?> getDashboardData(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6InJkaGdIaXVEd1BxdXRWcUhNZlhLbmc9PSIsInZhbHVlIjoiNkZYenJmL1FUSmM4VWdmOHR4K21TS1RaSjJtMzVCNE5hQjQvMmZHUWFQallzeHBxTFRjWGYwV1BETFdRUlE5bVJUVm5iak5RaFVnZ3k1MThQcEVINm5YeVdtaG9lRm5lditHQ0lxSHY1NEtEOE8vY1JyeUhtUkZWd3lBbE1YRU0iLCJtYWMiOiJiMzUwOTM2ZTBkNjkwNGE2NGI5YjU1MTUzZDk3MzQ4MzFiNTkxNzVkZGZhYzdiM2E3NzI1NTNkYjE1ODcxNTBkIiwidGFnIjoiIn0%3D; edocrequestapi_session=eyJpdiI6IjJDMTdBQnpneHYxWVE3TXdhWjNsT3c9PSIsInZhbHVlIjoicEdWakFjTmRxQkJJdWRkbWdrQkVhSnBKdnVUME4vdDJOSDNlSkhiR0srSGx2MnFCcGwrc0xOeDBLeEZIYkVUdHduS2pJTlFMSnRSRUdWMkRSL2wrMDd1dWJDcUhHUXZoN25Vby9Nd2Y5cktVdUw3YmtnODRpajIxU3YraTlxQkkiLCJtYWMiOiI1YTE3ZjBlNTBkZTNmZWZiNDM1MzQ3NTQyNzYwM2ZlYWI3YjE2NGEzOGJhZTVjZjAwYTE5MzhlYzdjNWE0MTA4IiwidGFnIjoiIn0%3D'
      };
      var data = json.encode(
          {"email": "toluwalopemi.shogade@gmail.com", "password": "12345678"});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/dashboard',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("dashboard data :: ${json.encode(response.data)}");
        return CitizenResponse.fromJson(response.data);
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

  Future<DocumentResponse?> getDocument(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6InJkaGdIaXVEd1BxdXRWcUhNZlhLbmc9PSIsInZhbHVlIjoiNkZYenJmL1FUSmM4VWdmOHR4K21TS1RaSjJtMzVCNE5hQjQvMmZHUWFQallzeHBxTFRjWGYwV1BETFdRUlE5bVJUVm5iak5RaFVnZ3k1MThQcEVINm5YeVdtaG9lRm5lditHQ0lxSHY1NEtEOE8vY1JyeUhtUkZWd3lBbE1YRU0iLCJtYWMiOiJiMzUwOTM2ZTBkNjkwNGE2NGI5YjU1MTUzZDk3MzQ4MzFiNTkxNzVkZGZhYzdiM2E3NzI1NTNkYjE1ODcxNTBkIiwidGFnIjoiIn0%3D; edocrequestapi_session=eyJpdiI6IjJDMTdBQnpneHYxWVE3TXdhWjNsT3c9PSIsInZhbHVlIjoicEdWakFjTmRxQkJJdWRkbWdrQkVhSnBKdnVUME4vdDJOSDNlSkhiR0srSGx2MnFCcGwrc0xOeDBLeEZIYkVUdHduS2pJTlFMSnRSRUdWMkRSL2wrMDd1dWJDcUhHUXZoN25Vby9Nd2Y5cktVdUw3YmtnODRpajIxU3YraTlxQkkiLCJtYWMiOiI1YTE3ZjBlNTBkZTNmZWZiNDM1MzQ3NTQyNzYwM2ZlYWI3YjE2NGEzOGJhZTVjZjAwYTE5MzhlYzdjNWE0MTA4IiwidGFnIjoiIn0%3D'
      };
      var data = json.encode(
          {"email": "toluwalopemi.shogade@gmail.com", "password": "12345678"});
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/citizen-documents',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
         print("document data :: ${json.encode(response.data)}");
         return DocumentResponse.fromJson(response.data);
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

  Future<void> getPayment(String token) async {
    try {
      var headers = {
        'Authorization':
            'Bearer $token',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6InJkaGdIaXVEd1BxdXRWcUhNZlhLbmc9PSIsInZhbHVlIjoiNkZYenJmL1FUSmM4VWdmOHR4K21TS1RaSjJtMzVCNE5hQjQvMmZHUWFQallzeHBxTFRjWGYwV1BETFdRUlE5bVJUVm5iak5RaFVnZ3k1MThQcEVINm5YeVdtaG9lRm5lditHQ0lxSHY1NEtEOE8vY1JyeUhtUkZWd3lBbE1YRU0iLCJtYWMiOiJiMzUwOTM2ZTBkNjkwNGE2NGI5YjU1MTUzZDk3MzQ4MzFiNTkxNzVkZGZhYzdiM2E3NzI1NTNkYjE1ODcxNTBkIiwidGFnIjoiIn0%3D; edocrequestapi_session=eyJpdiI6IjJDMTdBQnpneHYxWVE3TXdhWjNsT3c9PSIsInZhbHVlIjoicEdWakFjTmRxQkJJdWRkbWdrQkVhSnBKdnVUME4vdDJOSDNlSkhiR0srSGx2MnFCcGwrc0xOeDBLeEZIYkVUdHduS2pJTlFMSnRSRUdWMkRSL2wrMDd1dWJDcUhHUXZoN25Vby9Nd2Y5cktVdUw3YmtnODRpajIxU3YraTlxQkkiLCJtYWMiOiI1YTE3ZjBlNTBkZTNmZWZiNDM1MzQ3NTQyNzYwM2ZlYWI3YjE2NGEzOGJhZTVjZjAwYTE5MzhlYzdjNWE0MTA4IiwidGFnIjoiIn0%3D'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/citizen-payments',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print("payment data :: ${json.encode(response.data)}");
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
  }
}
