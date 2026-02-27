import 'package:dio/dio.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/card_request_response.dart';

abstract class CardRequestRemoteDataSource {
 Future<CardRequestResponse> requestCard({
   // required String requestType,
    bool includeDelivery = false, // ADD THIS
    String? line1, // ADD THIS
    String? line2, // ADD THIS
    String? state, // ADD THIS
    String? city, // ADD THIS
    String? zip, // ADD THIS
    String? country, // ADD THIS
  });}

class CardRequestRemoteDataSourceImpl implements CardRequestRemoteDataSource {
  final ApiService apiService;
  final String baseUrlExt = '/api/v1';

  CardRequestRemoteDataSourceImpl({required this.apiService});

  @override
  Future<CardRequestResponse> requestCard(
      {
        //required String requestType,
    bool includeDelivery = false,
    String? line1,
    String? line2,
    String? state,
    String? city,
    String? zip,
    String? country,}) async {
    try {
      print('🎫 Requesting card with delivery: $includeDelivery');

  // Build request body
      final Map<String, dynamic> requestBody = {
       // 'request_type': requestType,
        'include_delivery': includeDelivery,
      };

       if (includeDelivery) {
        requestBody.addAll({
          'line1': line1,
          'line2': line2,
          'state': state,
          'city': city,
          'zip': "0",
          'country': country,
        });
      }

      final response = await apiService.post(
          '$baseUrlExt/econsular/request-card',
          data: requestBody,
      );

      print('Card request response status: ${response.statusCode}');
      print('Card request response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final cardRequestResponse =
              CardRequestResponse.fromJson(response.data);

          if (cardRequestResponse.isSuccess) {
            print('✅ Card request initiated successfully');
            return cardRequestResponse;
          } else {
            throw ServerException(
              message: cardRequestResponse.message,
            );
          }
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse response: ${e.toString()}',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Card request failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 400) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Invalid request',
        );
      } else if (e.response?.statusCode == 401) {
        throw ServerException(message: 'Unauthorized. Please login again.');
      } else if (e.response?.statusCode == 409) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Card request already exists',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(
            message: 'Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.unknown) {
        throw NetworkException(message: 'No internet connection');
      } else {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Server error occurred',
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw ServerException(message: e.toString());
    }
  }
}
