import 'package:dio/dio.dart';
import 'package:e_consular_card/core/services/storage_service.dart';

class ApiService {
  final Dio _dio;

  final StorageService? storageService;

  final Function()? onUnauthorized;

  static const String baseUrl = 'https://dannongroup.org.ng';

  ApiService(this._dio, {this.storageService, this.onUnauthorized}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add request interceptor to attach token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token to headers if available
          if (storageService != null) {
            final token = storageService!.getFullToken();
            if (token != null) {
              options.headers['Authorization'] = token;
              print('Request with token: $token'); // Debug log
            }
          }

          print('REQUEST[${options.method}] => PATH: ${options.path}');
          print('REQUEST HEADERS: ${options.headers}');
          print('REQUEST DATA: ${options.data}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          print('RESPONSE DATA: ${response.data}');

          return handler.next(response);
        },
        onError: (error, handler) {
          print(
              'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          print('RESPONSE DATA: ${error.response?.data}');
          // Handle 401 Unauthorized
          if (error.response?.statusCode == 401) {
            print('❌ Unauthorized - Token expired or invalid');
            onUnauthorized?.call();
          }

          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data, bool isFormData = false}) async {
    try {
      return await _dio.post(path, data: data, options: Options(
        contentType: isFormData ? 'multipart/form-data' : 'application/json',
      ));
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handler
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        // Handle 401 Unauthorized - token expired or invalid
        if (statusCode == 401) {
          // TODO: You might want to trigger logout here
          return Exception('Session expired. Please login again.');
        }

        final message = error.response?.data['message'] ?? 'Request failed';
        return Exception('Error $statusCode: $message');

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      default:
        return Exception('Network error. Please check your connection.');
    }
  }
}
