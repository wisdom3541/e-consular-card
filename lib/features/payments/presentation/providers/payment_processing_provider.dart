import 'package:flutter/foundation.dart';
import '../../data/datasources/payment_remote_datasource.dart';
import '../../data/models/payment_initialization_response.dart';
import '../../data/models/payment_verification_response.dart';
import '../../../../core/errors/exceptions.dart';

class PaymentProcessingProvider extends ChangeNotifier {
  final PaymentRemoteDataSource? paymentDataSource;

  bool _isLoading = false;
  String? _errorMessage;
  PaymentInitializationData? _currentPayment;
  PaymentVerificationData? _verificationResult;

  PaymentProcessingProvider({this.paymentDataSource});

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  PaymentInitializationData? get currentPayment => _currentPayment;
  PaymentVerificationData? get verificationResult => _verificationResult;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<PaymentInitializationData?> initializePayment() async {
    _setLoading(true);
    _setError(null);

    try {
      if (paymentDataSource == null) {
        _setError('Payment service not available');
        _setLoading(false);
        return null;
      }

      final response = await paymentDataSource!.initializePayment();

      if (response.isSuccess) {
        _currentPayment = response.data;
        _setLoading(false);
        return response.data;
      } else {
        _setError('Payment initialization failed');
        _setLoading(false);
        return null;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return null;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return null;
    } catch (e) {
      _setError('Failed to initialize payment: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  Future<bool> verifyPayment(String reference) async {
    _setLoading(true);
    _setError(null);

    try {
      if (paymentDataSource == null) {
        _setError('Payment service not available');
        _setLoading(false);
        return false;
      }

      final response = await paymentDataSource!.verifyPayment(reference);

      if (response.isSuccess && response.data != null) {
        _verificationResult = response.data;
        _setLoading(false);
        return response.data!.isPaid;
      } else {
        _setError(response.message);
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
      _setError('Failed to verify payment: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  void reset() {
    _currentPayment = null;
    _verificationResult = null;
    _errorMessage = null;
    notifyListeners();
  }
}