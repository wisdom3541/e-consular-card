import 'package:dio/dio.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/dashboard_response.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardResponse> getDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiService apiService;
    final String baseUrlExt = '/api/v1'; 

  DashboardRemoteDataSourceImpl({required this.apiService});

  @override
  Future<DashboardResponse> getDashboardData() async {
    try {
      print('📊 Fetching dashboard data...');

      final response = await apiService.get('$baseUrlExt/econsular/citizen/dashboard');

      print('Dashboard response status: ${response.statusCode}');
      print('Dashboard response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final dashboardResponse = DashboardResponse.fromJson(response.data);

          if (dashboardResponse.isSuccess) {
            print('✅ Dashboard data loaded successfully');
            return dashboardResponse;
          } else {
            throw ServerException(
              message: 'Failed to load dashboard data',
            );
          }
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse dashboard data: ${e.toString()}',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load dashboard',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 401) {
        throw ServerException(message: 'Unauthorized. Please login again.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'Connection timeout. Please try again.');
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