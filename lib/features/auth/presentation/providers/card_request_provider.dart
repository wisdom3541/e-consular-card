import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
import 'package:flutter/foundation.dart';


class CardRequestProvider extends ChangeNotifier {
  // Available services
  final List<CardService> _availableServices = [
    const CardService(
      id: '1',
      name: 'eConsular Card',
      description: 'Consular service access card for Nigerians in Diaspora',
      amount: 100.00,
    ),
    const CardService(
      id: '2',
      name: 'NIN Verification Fee',
      description: 'NIN Verification Fee',
      amount: 25.00,
    ),
  ];

  // Selected services
  List<CardService> _selectedServices = [];
  bool _enableDelivery = false;
  final double _deliveryFee = 0.00;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<CardService> get availableServices => _availableServices;
  List<CardService> get selectedServices => _selectedServices;
  bool get enableDelivery => _enableDelivery;
  double get deliveryFee => _deliveryFee;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get serviceSubtotal {
    return _selectedServices.fold(
      0.0,
      (sum, service) => sum + service.amount,
    );
  }

  double get total {
    return serviceSubtotal + (_enableDelivery ? _deliveryFee : 0.0);
  }

  String get validityPeriod => '2 years';

  // Methods
  void toggleService(CardService service) {
    if (_selectedServices.contains(service)) {
      _selectedServices.remove(service);
    } else {
      _selectedServices.add(service);
    }
    notifyListeners();
  }

  void toggleDelivery(bool value) {
    _enableDelivery = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> submitCardRequest() async {
    if (!_selectedServices.isEmpty) {
      setError('Please select at least one service');
      return false;
    }

    setLoading(true);
    clearError();

    try {
      // TODO: Replace with actual API call when backend is ready
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful request
      setLoading(false);
      
      // Reset form
      _selectedServices = [];
      _enableDelivery = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      setError('Failed to submit request: ${e.toString()}');
      setLoading(false);
      return false;
    }
  }

  void reset() {
    _selectedServices = [];
    _enableDelivery = false;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}