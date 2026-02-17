import 'package:flutter/material.dart';

import '../../data/datasources/payment_remote_datasource.dart';
import '../../data/models/payment_history_response.dart';
import '../../../../core/errors/exceptions.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentRemoteDataSource? paymentDataSource;

  List<PaymentHistoryItem> _payments = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  // Pagination
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalPayments = 0;
  bool _hasMorePages = false;

  // Filters
  String? _searchQuery;
  String? _statusFilter;

  PaymentProvider({this.paymentDataSource});

  // Getters
  List<PaymentHistoryItem> get payments {
    var filteredPayments = _payments;

    // Apply status filter
    if (_statusFilter != null && _statusFilter != 'all') {
      filteredPayments = filteredPayments
          .where((p) => p.meta.status.toLowerCase() == _statusFilter!.toLowerCase())
          .toList();
    }

    // Apply search filter
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      filteredPayments = filteredPayments.where((payment) {
        final query = _searchQuery!.toLowerCase();
        return payment.reference.toLowerCase().contains(query) ||
            payment.meta.servicesDisplay.toLowerCase().contains(query);
      }).toList();
    }

    return filteredPayments;
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalPayments => _totalPayments;
  bool get hasMorePages => _hasMorePages;
  String? get statusFilter => _statusFilter;

  // Calculated stats

  double get totalAmount {
    // Only count successful payments
    return _payments
        .where((payment) => payment.meta.status.toLowerCase() == 'success')
        .fold(0.0, (sum, payment) => sum + payment.meta.amount);
  }

  // ADD: Total amount including all statuses (for reference if needed)
  double get totalAmountAll {
    return _payments.fold(0.0, (sum, payment) => sum + payment.meta.amount);
  }

  int get successCount {
    return _payments.where((p) => p.meta.status.toLowerCase() == 'success').length;
  }

  int get pendingCount {
    return _payments.where((p) => p.meta.status.toLowerCase() == 'pending').length;
  }

  int get failedCount {
    return _payments.where((p) => p.meta.status.toLowerCase() == 'failed').length;
  }

  // ADD: Total successful amount for clarity
  double get totalSuccessAmount {
    return _payments
        .where((payment) => payment.meta.status.toLowerCase() == 'success')
        .fold(0.0, (sum, payment) => sum + payment.meta.amount);
  }

  // ADD: Total pending amount
  double get totalPendingAmount {
    return _payments
        .where((payment) => payment.meta.status.toLowerCase() == 'pending')
        .fold(0.0, (sum, payment) => sum + payment.meta.amount);
  }

  // ADD: Total failed amount
  double get totalFailedAmount {
    return _payments
        .where((payment) => payment.meta.status.toLowerCase() == 'failed')
        .fold(0.0, (sum, payment) => sum + payment.meta.amount);
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

  // Load payment history
  Future<void> loadPaymentHistory({int page = 1}) async {
    _setLoading(true);
    _setError(null);

    try {
      if (paymentDataSource == null) {
        _setError('Payment service not available');
        _setLoading(false);
        return;
      }

      final response = await paymentDataSource!.getPaymentHistory(page: page);

      if (response.isSuccess) {
        if (page == 1) {
          // First page - replace all data
          _payments = response.data.payments;
        } else {
          // Additional pages - append data
          _payments.addAll(response.data.payments);
        }

        _currentPage = response.data.currentPage;
        _totalPages = response.data.lastPage;
        _totalPayments = response.data.total;
        _hasMorePages = response.data.hasMorePages;
      }

      _setLoading(false);

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load payments: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Load more payments (pagination)
  Future<void> loadMorePayments() async {
    if (!_hasMorePages || _isLoading) return;

    await loadPaymentHistory(page: _currentPage + 1);
  }

  // Refresh payments
  Future<void> refresh() async {
    await loadPaymentHistory(page: 1);
  }

  // Search
  void setSearchQuery(String? query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Filter by status
  void setStatusFilter(String? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = null;
    _statusFilter = null;
    notifyListeners();
  }
}