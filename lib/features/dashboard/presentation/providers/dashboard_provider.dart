import 'package:e_consular_card/core/errors/exceptions.dart';
import 'package:e_consular_card/features/auth/domain/entities/card_services.dart';
import 'package:e_consular_card/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:e_consular_card/features/dashboard/data/models/dashboard_response.dart';
import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {

  final DashboardRemoteDataSource? dashboardDataSource;

  // Dashboard data
  DashboardUser? _user;
  DashboardStats? _stats;
  List<RecentTransaction> _recentTransactions = [];
  PaginationInfo? _pagination;
  // User info
  String _userName = 'User';


  bool _registrationManuallyCompleted = false; 
  
  // Card request data
  UserCardRequest? _userCardRequest;
  
  // Filter state
  FilterType _selectedFilter = FilterType.all;
  
  // Counts
  int _allRequestsCount = 0;
  int _pendingCount = 0;
  int _approvedCount = 0;
  
  bool _isLoading = false;
  String? _errorMessage;

  DashboardProvider({this.dashboardDataSource});
  // Getters

  
  
  UserCardRequest? get userCardRequest => _userCardRequest;
  FilterType get selectedFilter => _selectedFilter;
  int get allRequestsCount => _allRequestsCount;
  int get pendingCount => _pendingCount;
  int get approvedCount => _approvedCount;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get registrationManuallyCompleted => _registrationManuallyCompleted; // ADD THIS

  



  DashboardUser? get user => _user;
  DashboardStats? get stats => _stats;
  List<RecentTransaction> get recentTransactions => _recentTransactions;
  PaginationInfo? get pagination => _pagination;
  
  bool get hasDashboardData => _user != null;
  String get userName => _user?.fullName ?? 'User';

  
  // ADD these getters for card status
  String? get cardReqStatus => _data?.cardReqStatus;
  CardStatus? get cardStatus => _data?.cardStatus;
  bool get hasCardRequest => _data?.hasCardRequest ?? false;
  bool get isCardApproved => _data?.isCardApproved ?? false;
  bool get hasActiveCard => _data?.hasActiveCard ?? false;
  bool get needsToCollectCard => _data?.needsToCollectCard ?? false;

  DashboardData? _data;

  // Methods
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setFilter(FilterType filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

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


  void markRegistrationAsComplete() {
    _registrationManuallyCompleted = true;
    notifyListeners();
  }


  Future<void> loadDashboardData() async {
    _setLoading(true);
    _setError(null);

    try {
      if (dashboardDataSource == null) {
        _setError('Dashboard data source not available');
        _setLoading(false);
        return;
      }

      final response = await dashboardDataSource!.getDashboardData();
      _data = response.data; // Store the entire response for card status access
      _user = response.data.user;
      _stats = response.data.stats;
      _recentTransactions = response.data.recentTransactions;
      _pagination = response.data.pagination;

      _setLoading(false);
    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load dashboard: ${e.toString()}');
      _setLoading(false);
    }
  }

  void refresh() {
    loadDashboardData();
  }

  // // Simulate loading dashboard data
  // Future<void> loadDashboardData() async {
  //   _setLoading(true);
  //   _setError(null);

  //   try {
  //     // TODO: Replace with actual API call
  //     await Future.delayed(const Duration(seconds: 1));

  //     // Simulate data
  //     _userName = 'John Doe';
      
  //     // Simulate a card request (you can remove this to test empty state)
  //     // _userCardRequest = UserCardRequest(
  //     //   id: '1',
  //     //   cardType: 'eConsular Card',
  //     //   description: 'Consular service access card for Nigerians in Diaspora',
  //     //   dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
  //     //   status: RequestStatus.processing, // Change this to test different states
  //     //   totalAmount: 125.00,
  //     // );

  //     // Update counts
  //     _allRequestsCount = _userCardRequest != null ? 1 : 0;
  //     _pendingCount = _userCardRequest?.status == RequestStatus.pending ? 1 : 0;
  //     _approvedCount = _userCardRequest?.status == RequestStatus.approved ? 1 : 0;

  //     _setLoading(false);
  //   } catch (e) {
  //     _setError('Failed to load dashboard data: ${e.toString()}');
  //     _setLoading(false);
  //   }
  // }

  void clearCardRequest() {
    _userCardRequest = null;
    _allRequestsCount = 0;
    _pendingCount = 0;
    _approvedCount = 0;
    notifyListeners();
  }
}

enum FilterType {
  all,
  pending,
  approved,
}