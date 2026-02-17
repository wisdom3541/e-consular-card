import 'package:flutter/foundation.dart';
import '../../data/datasources/location_remote_datasource.dart';
import '../../data/datasources/location_remote_datasource.dart';
import '../../data/models/location_models.dart';
import '../../errors/exceptions.dart';

class LocationProvider extends ChangeNotifier {
  final LocationRemoteDataSource? locationDataSource;

  List<Country> _countries = [];
  List<StateModel> _states = [];
  List<Lga> _lgas = [];

  bool _isLoadingCountries = false;
  bool _isLoadingStates = false;
  bool _isLoadingLgas = false;

  String? _errorMessage;

  LocationProvider({this.locationDataSource});

  // Getters
  List<Country> get countries => _countries;
  List<StateModel> get states => _states;
  List<Lga> get lgas => _lgas;

  bool get isLoadingCountries => _isLoadingCountries;
  bool get isLoadingStates => _isLoadingStates;
  bool get isLoadingLgas => _isLoadingLgas;

  String? get errorMessage => _errorMessage;

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Load Countries
  Future<void> loadCountries() async {
    if (_countries.isNotEmpty) return; // Already loaded

    _isLoadingCountries = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (locationDataSource == null) {
        _setError('Location service not available');
        _isLoadingCountries = false;
        notifyListeners();
        return;
      }

      final response = await locationDataSource!.getCountries();

      if (response.isSuccess) {
        _countries = response.data;
      }

      _isLoadingCountries = false;
      notifyListeners();

    } on ServerException catch (e) {
      _setError(e.message);
      _isLoadingCountries = false;
      notifyListeners();
    } on NetworkException catch (e) {
      _setError(e.message);
      _isLoadingCountries = false;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load countries: ${e.toString()}');
      _isLoadingCountries = false;
      notifyListeners();
    }
  }

  // Load States for a country
  Future<void> loadStates(int countryId) async {
    _isLoadingStates = true;
    _states = []; // Clear previous states
    _lgas = []; // Clear LGAs when country changes
    _errorMessage = null;
    notifyListeners();

    try {
      if (locationDataSource == null) {
        _setError('Location service not available');
        _isLoadingStates = false;
        notifyListeners();
        return;
      }

      final response = await locationDataSource!.getStates(countryId);

      if (response.isSuccess) {
        _states = response.data;
      }

      _isLoadingStates = false;
      notifyListeners();

    } on ServerException catch (e) {
      _setError(e.message);
      _isLoadingStates = false;
      notifyListeners();
    } on NetworkException catch (e) {
      _setError(e.message);
      _isLoadingStates = false;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load states: ${e.toString()}');
      _isLoadingStates = false;
      notifyListeners();
    }
  }

  // Load LGAs for a state
  Future<void> loadLgas(int stateId) async {
    _isLoadingLgas = true;
    _lgas = []; // Clear previous LGAs
    _errorMessage = null;
    notifyListeners();

    try {
      if (locationDataSource == null) {
        _setError('Location service not available');
        _isLoadingLgas = false;
        notifyListeners();
        return;
      }

      final response = await locationDataSource!.getLgas(stateId);

      if (response.isSuccess) {
        _lgas = response.data;
      }

      _isLoadingLgas = false;
      notifyListeners();

    } on ServerException catch (e) {
      _setError(e.message);
      _isLoadingLgas = false;
      notifyListeners();
    } on NetworkException catch (e) {
      _setError(e.message);
      _isLoadingLgas = false;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load LGAs: ${e.toString()}');
      _isLoadingLgas = false;
      notifyListeners();
    }
  }

  // Get country by ID
  Country? getCountryById(int id) {
    try {
      return _countries.firstWhere((country) => country.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get state by ID
  StateModel? getStateById(int id) {
    try {
      return _states.firstWhere((state) => state.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get LGA by ID
  Lga? getLgaById(int id) {
    try {
      return _lgas.firstWhere((lga) => lga.id == id);
    } catch (e) {
      return null;
    }
  }
}