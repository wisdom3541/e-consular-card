import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/signature_upload_response.dart';
import '../models/signature_fetch_response.dart';

abstract class SignatureRemoteDataSource {
  Future<SignatureUploadResponse> uploadSignature(File imageFile);
  Future<SignatureFetchResponse> fetchSignature();
}

class SignatureRemoteDataSourceImpl implements SignatureRemoteDataSource {
  final ApiService apiService;
  final String baseUrlExt = "/api/v1";

  SignatureRemoteDataSourceImpl({required this.apiService});

  @override
  Future<SignatureUploadResponse> uploadSignature(File imageFile) async {
    try {
      print('📤 Uploading signature: ${imageFile.path}');

      // Create multipart file
      String fileName = imageFile.path.split('/').last;
      
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType('image', 'png'), // Adjust based on file type
        ),
      });

      final response = await apiService.post(
        '$baseUrlExt/econsular/upload-signature',
        data: formData,
      );

      print('Signature upload response status: ${response.statusCode}');
      print('Signature upload response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final uploadResponse = SignatureUploadResponse.fromJson(response.data);

          if (uploadResponse.isSuccess) {
            print('✅ Signature uploaded successfully');
            return uploadResponse;
          } else {
            throw ServerException(
              message: uploadResponse.message,
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
          message: response.data['message'] ?? 'Signature upload failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 400) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Invalid file',
        );
      } else if (e.response?.statusCode == 413) {
        throw ServerException(message: 'File size too large');
      } else if (e.response?.statusCode == 415) {
        throw ServerException(message: 'Unsupported file type');
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

  @override
  Future<SignatureFetchResponse> fetchSignature() async {
    try {
      print('📥 Fetching signature...');

      final response = await apiService.get('$baseUrlExt/econsular/fetch-signature');

      print('Fetch signature response status: ${response.statusCode}');
      print('Fetch signature response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final fetchResponse = SignatureFetchResponse.fromJson(response.data);

          if (fetchResponse.isSuccess) {
            print('✅ Signature fetched successfully');
            return fetchResponse;
          } else {
            throw ServerException(
              message: fetchResponse.message,
            );
          }
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse response: ${e.toString()}',
          );
        }
      } else if (response.statusCode == 404) {
        // No signature uploaded yet - this is OK
        return SignatureFetchResponse(
          status: 'success',
          message: 'No signature found',
          data: null,
        );
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch signature',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 404) {
        // No signature found - return empty response
        return SignatureFetchResponse(
          status: 'success',
          message: 'No signature found',
          data: null,
        );
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