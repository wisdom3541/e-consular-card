import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../errors/exceptions.dart';
import '../models/location_models.dart';

abstract class LocationRemoteDataSource {
  Future<CountryResponse> getCountries();
  Future<StateResponse> getStates(int countryId);
  Future<LgaResponse> getLgas(int stateId);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final ApiService apiService;
  final String baseUrlExt = "/api/v1";

  LocationRemoteDataSourceImpl({required this.apiService});

  @override
  Future<CountryResponse> getCountries() async {
    try {
      print('🌍 Fetching countries...');

      final response = await apiService.get('$baseUrlExt/econsular/countries');

      print('Countries response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final countryResponse = CountryResponse.fromJson(response.data);

        if (countryResponse.isSuccess) {
          print('✅ Loaded ${countryResponse.data.length} countries');
          return countryResponse;
        } else {
          throw ServerException(message: 'Failed to load countries');
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load countries',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<StateResponse> getStates(int countryId) async {
    try {
      print('🏙️ Fetching states for country: $countryId');

      final response = await apiService.get('$baseUrlExt/econsular/countries/$countryId/states');

      print('States response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final stateResponse = StateResponse.fromJson(response.data);

        if (stateResponse.isSuccess) {
          print('✅ Loaded ${stateResponse.data.length} states');
          return stateResponse;
        } else {
          throw ServerException(message: 'Failed to load states');
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load states',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<LgaResponse> getLgas(int stateId) async {
    try {
      print('🏘️ Fetching LGAs for state: $stateId');

      final response = await apiService.get('$baseUrlExt/econsular/states/$stateId/lgas');

      print('LGAs response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final lgaResponse = LgaResponse.fromJson(response.data);

        if (lgaResponse.isSuccess) {
          print('✅ Loaded ${lgaResponse.data.length} LGAs');
          return lgaResponse;
        } else {
          throw ServerException(message: 'Failed to load LGAs');
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to load LGAs',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response?.statusCode == 404) {
      return ServerException(message: 'Resource not found');
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException(message: 'Connection timeout. Please try again.');
    } else if (e.type == DioExceptionType.unknown) {
      return NetworkException(message: 'No internet connection');
    } else {
      return ServerException(
        message: e.response?.data['message'] ?? 'Server error occurred',
      );
    }
  }
}