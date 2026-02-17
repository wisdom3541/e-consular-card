import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_consular_card/features/auth/data/model/complete_registration_response.dart';
import 'package:e_consular_card/features/auth/data/model/login_otp_verification_response.dart';
import 'package:e_consular_card/features/auth/data/model/login_response.dart';
import 'package:e_consular_card/features/auth/data/model/nin_verification_response.dart';
import 'package:e_consular_card/features/auth/data/model/otp_verification_response.dart';
import 'package:e_consular_card/features/auth/data/model/registration_response.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<NinVerificationResponse> verifyNin(String nin);
  Future<RegistrationResponse> registerWithNin({
    required String email,
    required String nin,
    required String password,
    required String passwordConfirmation,
  });

  Future<RegistrationResponse> registerManually({
    required String firstName,
    required String lastName,
    required String email,
    required File birthCertificate,
    required String password,
    required String passwordConfirmation,
  });

  Future<LoginResponse> login({
    required String email,
    required String password,
  });
  Future<LoginOtpVerificationResponse> verifyLoginOtp({
    required String email,
    required String otp,
  });

  Future<OtpVerificationResponse> verifyOtp(String otp);
  Future<OtpVerificationResponse> resendOtp(String email);

  Future<CompleteRegistrationResponse> completeRegistration({
    required int countryId,
    required int stateId,
    required int lgaId,
    required String means,
    required String identification,
    required String expiryDate,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String height,
    required String educationalQualification,
    required String profession,
    required String citizenBy,
    required String motherMaidenName,
    required String maritalStatus,
    required String kinFirstName,
    required String kinLastName,
    required String kinPhone,
    required String kinRelationship,
    required String kinEmail,
    required String kinAddress,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final String baseUrlExt = '/api/v1';

  AuthRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<NinVerificationResponse> verifyNin(String nin) async {
    try {
      print('Verifying NIN: $nin');

      final response = await apiService.get(
        '/econsular/nvs-sample-api', // Update endpoint if needed
        queryParameters: {'nin': nin},
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final verificationResponse =
            NinVerificationResponse.fromJson(response.data);

        if (verificationResponse.isSuccess) {
          return verificationResponse;
        } else {
          throw ServerException(
            message: 'NIN verification failed: Invalid response status',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'NIN verification failed',
        );
      }
    } on DioException catch (e) {
      // Error handling...
      throw _handleDioError(e);
    }
  }

  @override
  Future<RegistrationResponse> registerWithNin({
    required String email,
    required String nin,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      print('Registering with NIN: $nin, Email: $email');

      final response = await apiService.post(
        '$baseUrlExt/econsular/register/with-nin', // TODO: Update this endpoint path
        data: {
          'email': email,
          'nin': nin,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      print('Registration response status: ${response.statusCode}');
      print('Registration response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final registrationResponse =
              RegistrationResponse.fromJson(response.data);

          if (registrationResponse.isSuccess) {
            return registrationResponse;
          } else {
            throw ServerException(
              message: registrationResponse.message,
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
          message: response.data['message'] ?? 'Registration failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 422) {
        // Validation error
        final errors = e.response?.data['errors'];
        if (errors != null) {
          final errorMessages = <String>[];
          errors.forEach((key, value) {
            if (value is List) {
              errorMessages.addAll(value.cast<String>());
            }
          });
          throw ServerException(
            message: errorMessages.isNotEmpty
                ? errorMessages.join('\n')
                : 'Validation failed',
          );
        }
        throw ServerException(
          message: e.response?.data['message'] ?? 'Invalid data provided',
        );
      } else if (e.response?.statusCode == 409) {
        throw ServerException(message: 'Email or NIN already registered');
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
  Future<OtpVerificationResponse> verifyOtp(String otp) async {
    try {
      print('Verifying OTP: $otp');

      final response = await apiService.post(
        '$baseUrlExt/econsular/register/verify-otp', // TODO: Update this endpoint path
        data: {'otp': otp},
      );

      print('OTP verification response status: ${response.statusCode}');
      print('OTP verification response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final otpResponse = OtpVerificationResponse.fromJson(response.data);

          if (otpResponse.isSuccess) {
            return otpResponse;
          } else {
            throw ServerException(
              message: otpResponse.message,
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
          message: response.data['message'] ?? 'OTP verification failed',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Invalid OTP',
        );
      } else if (e.response?.statusCode == 410) {
        throw ServerException(
            message: 'OTP has expired. Please request a new one.');
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
  Future<OtpVerificationResponse> resendOtp(String email) async {
    try {
      print('Resending OTP to: $email');

      final response = await apiService.post(
        '${baseUrlExt}resend-otp', // TODO: Update this endpoint path
        data: {'email': email},
      );

      print('Resend OTP response status: ${response.statusCode}');
      print('Resend OTP response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          // Resend might return similar structure or just success message
          final otpResponse = OtpVerificationResponse.fromJson(response.data);
          return otpResponse;
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse response: ${e.toString()}',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to resend OTP',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');

      if (e.response?.statusCode == 429) {
        throw ServerException(
          message: 'Too many requests. Please wait before trying again.',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(
            message: 'Connection timeout. Please try again.');
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

//login with email and password
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Logging in with email: $email');

      final response = await apiService.post(
        '$baseUrlExt/econsular/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print('Login response status: ${response.statusCode}');
      print('Login response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final loginResponse = LoginResponse.fromJson(response.data);

          if (loginResponse.isSuccess) {
            return loginResponse;
          } else {
            throw ServerException(message: loginResponse.message);
          }
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse response: ${e.toString()}',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Login failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

//login otp verification
  @override
  Future<LoginOtpVerificationResponse> verifyLoginOtp({
    required String email,
    required String otp,
  }) async {
    try {
      print('Verifying login OTP for: $email');

      final response = await apiService.post(
        '$baseUrlExt/econsular/login/verify-otp', // TODO: Update endpoint if different
        data: {
          'email': email,
          'otp': otp,
        },
      );

      print('Login OTP verification response status: ${response.statusCode}');
      print('Login OTP verification response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          final otpResponse =
              LoginOtpVerificationResponse.fromJson(response.data);

          if (otpResponse.isSuccess) {
            return otpResponse;
          } else {
            throw ServerException(message: otpResponse.message);
          }
        } catch (e) {
          print('Parsing error: $e');
          throw ServerException(
            message: 'Failed to parse response: ${e.toString()}',
          );
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'OTP verification failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

//complete registration with all required fields with NIN
  @override
  Future<CompleteRegistrationResponse> completeRegistration({
    required int countryId,
    required int stateId,
    required int lgaId,
    required String means,
    required String identification,
    required String expiryDate,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String height,
    required String educationalQualification,
    required String profession,
    required String citizenBy,
    required String motherMaidenName,
    required String maritalStatus,
    required String kinFirstName,
    required String kinLastName,
    required String kinPhone,
    required String kinRelationship,
    required String kinEmail,
    required String kinAddress,
  }) async {
    try {
      print('Completing registration...');

      final response = await apiService.post(
        '$baseUrlExt/econsular/register/complete',
        data: {
          'country_id': 45,
          "state_id": stateId,
          "lga_id": lgaId,
          'means': means,
          'identification': identification,
          'expiry_date': expiryDate,
          'first_name': firstName,
          'last_name': lastName,
          'address': address,
          'phone': phone,
          'height': height,
          'educational_qualification': educationalQualification,
          'profession': profession,
          'citizen_by': citizenBy,
          'mother_maiden_name': motherMaidenName,
          'marital_status': maritalStatus,
          'kin_first_name': kinFirstName,
          'kin_last_name': kinLastName,
          'kin_phone': kinPhone,
          'kin_relationship': kinRelationship,
          'kin_email': kinEmail,
          'kin_address': kinAddress,
        },
      );

      print('Complete registration response status: ${response.statusCode}');
      print('Complete registration response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final completeRegResponse =
            CompleteRegistrationResponse.fromJson(response.data);

        if (completeRegResponse.isSuccess) {
          return completeRegResponse;
        } else {
          throw ServerException(message: completeRegResponse.message);
        }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Registration completion failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Centralized error handler
  Exception _handleDioError(DioException e) {
    if (e.response?.statusCode == 422) {
      final errors = e.response?.data['errors'];
      if (errors != null) {
        final errorMessages = <String>[];
        errors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.cast<String>());
          }
        });
        return ServerException(
          message: errorMessages.isNotEmpty
              ? errorMessages.join('\n')
              : 'Validation failed',
        );
      }
      return ServerException(
        message: e.response?.data['message'] ?? 'Invalid data provided',
      );
    } else if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      return ServerException(
        message: e.response?.data['message'] ?? 'Request failed',
      );
    } else if (e.response?.statusCode == 404) {
      return ServerException(message: 'Resource not found');
    } else if (e.response?.statusCode == 409) {
      return ServerException(message: 'Resource already exists');
    } else if (e.response?.statusCode == 410) {
      return ServerException(message: 'Resource has expired');
    } else if (e.response?.statusCode == 429) {
      return ServerException(
        message: 'Too many requests. Please wait before trying again.',
      );
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

  @override
  Future<RegistrationResponse> registerManually(
      {required String firstName,
      required String lastName,
      required String email,
      required File birthCertificate,
      required String password,
      required String passwordConfirmation}) async {
    try {
      print('Registering Manually: First Name: $firstName, Last Name: $lastName');

FormData formData = FormData.fromMap({
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "birth_certificate": await MultipartFile.fromFile(
      birthCertificate.path,
      filename: birthCertificate.path.split('/').last,
    ),
  });
      final response = await apiService.post(
        '$baseUrlExt/econsular/register/without-nin',
        isFormData: true,
        data: formData,
      );

      print('Complete registration response status: ${response.statusCode}');
      print('Complete registration response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
      final registrationResponse =
              RegistrationResponse.fromJson(response.data);

        if (registrationResponse.isSuccess) {
            return registrationResponse;
          } else {
            throw ServerException(
              message: registrationResponse.message,
            );
          }
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Registration completion failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
