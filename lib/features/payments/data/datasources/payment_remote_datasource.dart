import 'package:dio/dio.dart';
import 'package:e_consular_card/features/payments/data/models/payment_history_response.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/payment_initialization_response.dart';
import '../models/payment_verification_response.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentInitializationResponse> initializePayment();
  Future<PaymentVerificationResponse> verifyPayment(String reference);
  Future<PaymentHistoryResponse> getPaymentHistory({int page = 1});
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final ApiService apiService;
  final String baseUrlExt = "/api/v1";

  PaymentRemoteDataSourceImpl({required this.apiService});

  @override
  Future<PaymentInitializationResponse> initializePayment() async {
    try {
      print('💳 Initializing payment...');

      final response = await apiService.post(
        '$baseUrlExt/econsular/payment/initiate-globalpay',
        data: {}, // Empty body, only uses auth token
      );

      print('Payment initialization response status: ${response.statusCode}');
      print('Payment initialization response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final paymentResponse =
              PaymentInitializationResponse.fromJson(response.data);

          if (paymentResponse.isSuccess) {
            print('✅ Payment initialized successfully');
            return paymentResponse;
          } else {
            throw ServerException(
              message: 'Payment initialization failed',
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
          message: response.data['message'] ?? 'Payment initialization failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 400) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Invalid payment request',
        );
      } else if (e.response?.statusCode == 409) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Payment already exists',
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

  @override
  Future<PaymentVerificationResponse> verifyPayment(String reference) async {
    try {
      print('✅ Verifying payment with reference: $reference');

      final response = await apiService.get(
        '$baseUrlExt/econsular/payment/verify-globalpay/$reference',
        // data: {
        //   //'reference': reference,
        // },
      );

      print('Payment verification response status: ${response.statusCode}');
      print('Payment verification response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final verificationResponse =
              PaymentVerificationResponse.fromJson(response.data);

          if (verificationResponse.isSuccess) {
            print('✅ Payment verified successfully');
            return verificationResponse;
          } else {
            throw ServerException(
              message: verificationResponse.message,
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
          message: response.data['message'] ?? 'Payment verification failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 404) {
        throw ServerException(message: 'Payment reference not found');
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

  @override
  Future<PaymentHistoryResponse> getPaymentHistory({int page = 1}) async {
    try {
      print('📜 Fetching payment history (page: $page)...');

      final response = await apiService.get(
        '$baseUrlExt/econsular/citizen/payments',
        queryParameters: {'page': page},
      );

      print('Payment history response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          final historyResponse =
              PaymentHistoryResponse.fromJson(response.data);

          if (historyResponse.isSuccess) {
            print('✅ Loaded ${historyResponse.data.payments.length} payments');
            return historyResponse;
          } else {
            throw ServerException(
              message: 'Failed to load payment history',
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
          message: response.data['message'] ?? 'Failed to load payments',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 404) {
        // No payments found - return empty response
        return PaymentHistoryResponse(
          status: 'success',
          data: PaymentHistoryData(
            currentPage: 1,
            payments: [],
            firstPage: 1,
            lastPage: 1,
            perPage: 10,
            total: 0,
          ),
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
