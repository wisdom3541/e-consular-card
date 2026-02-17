import 'dart:io';
import 'package:e_consular_card/core/errors/exceptions.dart';
import 'package:e_consular_card/core/services/storage_service.dart';
import 'package:e_consular_card/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_consular_card/features/auth/domain/entities/nin_verification.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/registration_request.dart';

class AuthProvider extends ChangeNotifier {

  final AuthRemoteDataSource? authDataSource;

  final StorageService? storageService; 
  
  // State

  User? _user;
  String? _accessToken;
  bool _isAuthenticated = false;
  bool _isNinRegistration = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _prefilledNin; // For NIN that comes from verification screen

  int? _otpReference;
  String? _registeredEmail;


  String? _loginEmail; // Store email for login OTP verification
  int? _loginOtpReference; // Store OTP reference for login

  AuthProvider({
    this.authDataSource,
    this.storageService,
  }) {
    _checkAuthStatus();
  }
  // Add these properties
  NinVerification? _ninVerification;


  // Getters
    User? get user => _user;
  String? get accessToken => _accessToken;
  bool get isAuthenticated => _isAuthenticated;
  bool get isNinRegistration => _isNinRegistration;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  int? get otpReference => _otpReference;
  String? get registeredEmail => _registeredEmail;
  String? get prefilledNin => _prefilledNin;
  NinVerification? get ninVerification => _ninVerification;


  String? get loginEmail => _loginEmail;
  int? get loginOtpReference => _loginOtpReference;

Future<void> checkAuthStatus() async {
    await _checkAuthStatus();
  }

  // Set registration type
  void setNinRegistrationType(bool value) {
    _isNinRegistration = value;
    notifyListeners();
  }

  // Set prefilled NIN (from verification screen)
  void setPrefilledNin(String nin) {
    _prefilledNin = nin;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set error
  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }


  // Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    if (storageService != null) {
      _isAuthenticated = storageService!.isLoggedIn();
      if (_isAuthenticated) {
        _accessToken = storageService!.getAccessToken();
        // Load user data from storage
        final userId = storageService!.getUserId();
        final userEmail = storageService!.getUserEmail();
        final userName = storageService!.getUserFullName();

        if (userId != null && userEmail != null && userName != null) {
          final nameParts = userName.split(' ');
          _user = User(
            id: userId,
            firstName: nameParts.isNotEmpty ? nameParts[0] : '',
            lastName: nameParts.length > 1 ? nameParts[1] : '',
            email: userEmail,
            nin: '', // We can store this too if needed
            phone: '',
          );
        }
      }
      notifyListeners();
    }
  }

  


  Future<bool> registerWithNin({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      // Validate we have NIN data
      if (_prefilledNin == null || _prefilledNin!.isEmpty) {
        _setError('NIN not verified. Please verify your NIN first.');
        _setLoading(false);
        return false;
      }


      // Real API call
      final response = await authDataSource!.registerWithNin(
        email: email,
        nin: _prefilledNin!,
        password: password,
        passwordConfirmation: password,
      );

      // Store OTP reference and email for verification
      _otpReference = response.data?.otpReference;
      _registeredEmail = email;

      _setLoading(false);
      return true;

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Clear registration data
  void clearRegistrationData() {
    _otpReference = null;
    _registeredEmail = null;
    _ninVerification = null;
    _prefilledNin = null;
    notifyListeners();
  }


Future<bool> registerManually({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required File birthCertificate,
}) async {
  _setLoading(true);
  _setError(null);

  try {

    print('Starting manual registration with email: $email');
 
 //  API call
      final response = await authDataSource!.registerManually(
        email: email,
        password: password,
        passwordConfirmation: password,
        firstName: firstName,
        lastName: lastName,
        birthCertificate: birthCertificate,
      );

    // Store OTP reference and email for verification
      _otpReference = response.data?.otpReference;
      _registeredEmail = email;

    _setLoading(false);
      return true;

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
}



  // Update verifyNin method
  Future<bool> verifyNin(String nin) async {
    _setLoading(true);
    _setError(null);

    try {
      if (authDataSource == null) {
        // Fallback to mock data if no datasource
        await Future.delayed(const Duration(seconds: 2));
        
        _ninVerification = NinVerification(
          nin: nin,
          firstName: 'JOHN',
          middleName: 'DOE',
          lastName: 'SMITH',
          email: 'dummy@example.com',
          phoneNumber: '08012345678',
          dateOfBirth: '1990-01-01',
          gender: 'M',
        );
        
        setPrefilledNin(nin);
        _setLoading(false);
        return true;
      }
      
      // Real API call
      final response = await authDataSource!.verifyNin(nin);
      
      // Convert to domain entity
      _ninVerification = NinVerification(
        nin: response.data.nin,
        firstName: response.data.firstname,
        middleName: response.data.middlename,
        lastName: response.data.surname,
        email: response.data.email,
        phoneNumber: response.data.telephoneno,
        dateOfBirth: response.data.formattedBirthdate,
        gender: response.data.gender.toUpperCase(),
        photo: response.data.photo,
        signature: response.data.signature,
      );
      
      // Store the NIN for registration
      setPrefilledNin(nin);
      
      _setLoading(false);
      return true;
      
    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }



  Future<bool> verifyOtp(String otp) async {
    _setLoading(true);
    _setError(null);

    try {
      

      // Real API call
      final response = await authDataSource!.verifyOtp(otp);

      if (response.data != null) {
        // Save access token
        _accessToken = response.data!.accessToken;
        
        if (storageService != null) {
          await storageService!.saveAccessToken(
            response.data!.accessToken,
            response.data!.tokenType,
          );
          
          // Save user data
          await storageService!.saveUserData(
            userId: response.data!.user.id,
            email: response.data!.user.email,
            firstName: response.data!.user.firstname,
            lastName: response.data!.user.surname,
          );
        }

        // Create user entity
        _user = User(
          id: response.data!.user.id,
          firstName: response.data!.user.firstname,
          lastName: response.data!.user.surname,
          email: response.data!.user.email,
          nin: response.data!.user.nin,
          phone: response.data!.user.phone,
          profession: response.data!.user.profession,
        );

        _isAuthenticated = true;
        
        // Clear registration data
        clearRegistrationData();
        
        _setLoading(false);
        return true;
      } else {
        _setError('Invalid response from server');
        _setLoading(false);
        return false;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resendOtp() async {
    _setLoading(true);
    _setError(null);

    try {
      if (_registeredEmail == null) {
        _setError('Email not found. Please register again.');
        _setLoading(false);
        return false;
      }

      if (authDataSource == null) {
        // Fallback to mock
        await Future.delayed(const Duration(seconds: 1));
        _setLoading(false);
        return true;
      }

      // Real API call
     // await authDataSource!.resendOtp(_registeredEmail!);
      
      _setLoading(false);
      return true;

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }


  // login with email and password

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await authDataSource!.login(
        email: email,
        password: password,
      );

      // Store email and OTP reference for verification
      _loginEmail = response.data?.email ?? email;
      _loginOtpReference = response.data?.otpReference;

      _setLoading(false);
      return true;

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyLoginOtp(String otp) async {
    _setLoading(true);
    _setError(null);

    try {
      if (_loginEmail == null) {
        _setError('Email not found. Please login again.');
        _setLoading(false);
        return false;
      }

      final response = await authDataSource!.verifyLoginOtp(
        email: _loginEmail!,
        otp: otp,
      );

      if (response.data != null) {
        // Save access token
        _accessToken = response.data!.accessToken;

        if (storageService != null) {
          await storageService!.saveAccessToken(
            response.data!.accessToken,
            response.data!.tokenType,
          );

          print('✅ Login token saved: ${response.data!.tokenType} ${response.data!.accessToken}');

          // Save user data
          await storageService!.saveUserData(
            userId: response.data!.user.id,
            email: response.data!.user.email,
            firstName: response.data!.user.firstname,
            lastName: response.data!.user.surname,
          );
        }

        // Create user entity
        _user = User(
          id: response.data!.user.id,
          firstName: response.data!.user.firstname,
          lastName: response.data!.user.surname,
          email: response.data!.user.email,
          nin: response.data!.user.nin,
          phone: response.data!.user.phone,
          profession: response.data!.user.profession,
        );

        _isAuthenticated = true;

        // Clear login data
        _loginEmail = null;
        _loginOtpReference = null;

        _setLoading(false);
        return true;
      } else {
        _setError('Invalid response from server');
        _setLoading(false);
        return false;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }


  Future<bool> completeRegistration({
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
    _setLoading(true);
    _setError(null);

    try {
      final response = await authDataSource!.completeRegistration(
        countryId: countryId,
        stateId: stateId,
        lgaId: lgaId,
        means: means,
        identification: identification,
        expiryDate: expiryDate,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phone: phone,
        height: height,
        educationalQualification: educationalQualification,
        profession: profession,
        citizenBy: citizenBy,
        motherMaidenName: motherMaidenName,
        maritalStatus: maritalStatus,
        kinFirstName: kinFirstName,
        kinLastName: kinLastName,
        kinPhone: kinPhone,
        kinRelationship: kinRelationship,
        kinEmail: kinEmail,
        kinAddress: kinAddress,
      );

      if (response.data != null) {
        // Update user with complete data
        _user = User(
          id: response.data!.id,
          firstName: response.data!.firstname,
          lastName: response.data!.surname,
          email: response.data!.email,
          nin: response.data!.nin,
          phone: response.data!.phone,
          profession: response.data!.profession,
        );

        // Update storage with updated user info
        if (storageService != null) {
          await storageService!.saveUserData(
            userId: response.data!.id,
            email: response.data!.email,
            firstName: response.data!.firstname,
            lastName: response.data!.surname,
          );
        }

        _setLoading(false);
        return true;
      } else {
        _setError('Invalid response from server');
        _setLoading(false);
        return false;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }


  // Logout
  Future<void> logout() async {
    if (storageService != null) {
      await storageService!.clearAll();
    }
    
    _user = null;
    _accessToken = null;
    _isAuthenticated = false;
    clearRegistrationData();
    
    notifyListeners();
  }


void handleTokenExpiration() {
  logout();
}

  // Reset provider (useful for logout or starting fresh)
  void reset() {
    _isNinRegistration = false;
    _isLoading = false;
    _errorMessage = null;
    _user = null;
    _prefilledNin = null;
    notifyListeners();
  }
}