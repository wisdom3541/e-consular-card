import 'package:flutter/foundation.dart';
import '../../data/datasources/card_request_remote_datasource.dart';
import '../../data/models/card_request_response.dart';
import '../../../../core/errors/exceptions.dart';

class CardRequestProvider extends ChangeNotifier {
  final CardRequestRemoteDataSource? cardRequestDataSource;

  // State
  bool _isLoading = false;
  String? _errorMessage;
  CardRequestData? _currentRequest;

  // Delivery option
  bool _includeDelivery = false;

  // Constructor
  CardRequestProvider({this.cardRequestDataSource});

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CardRequestData? get currentRequest => _currentRequest;
  bool get includeDelivery => _includeDelivery;

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

  void setIncludeDelivery(bool value) {
    _includeDelivery = value;
    notifyListeners();
  }

  Future<bool> submitCardRequest({
   // required String requestType,
    bool includeDelivery = false,
    String? line1, 
    String? line2, 
    String? state, 
    String? city,
    String? zip, 
    String? country, 
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      if (cardRequestDataSource == null) {
        _setError('Card request service not available');
        _setLoading(false);
        return false;
      }

      final response = await cardRequestDataSource!.requestCard(
       // requestType: requestType,
        includeDelivery: includeDelivery,
        line1: line1,
        line2: line2,
        state: state,
        city: city,
        zip: zip,
        country: country,
      );

      if (response.data != null) {
        _currentRequest = response.data;
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
      _setError('Failed to submit request: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  void reset() {
    _currentRequest = null;
    _includeDelivery = false;
    _errorMessage = null;
    notifyListeners();
  }
}