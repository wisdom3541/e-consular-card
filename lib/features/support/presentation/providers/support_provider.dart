import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../data/datasources/support_remote_datasource.dart';
import '../../data/models/support_ticket_models.dart';
import '../../../../core/errors/exceptions.dart';

class SupportProvider extends ChangeNotifier {
  final SupportRemoteDataSource? supportDataSource;

  List<SupportTicket> _tickets = [];

  SingleTicketData? _selectedTicketData; 
  List<TicketReply> _replies = [];

  bool _isLoading = false;
  bool _isLoadingReplies = false;
  String? _errorMessage;

  // Pagination
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMorePages = false;

  // Reply pagination
  int _currentReplyPage = 1;
  int _totalReplyPages = 1;
  bool _hasMoreReplies = false;

  // Filters
  String? _statusFilter;
  String? _priorityFilter;

  SupportProvider({this.supportDataSource});

  // Getters

  SingleTicketData? get selectedTicketData => _selectedTicketData; // ADD THIS
  SupportTicket? get selectedTicket => _tickets.firstWhere(
        (t) => t.id == _selectedTicketData?.id,
        orElse: () => _tickets.first,
      ); // Keep for compatibility
  List<TicketReply> get replies => _replies;
  List<SupportTicket> get tickets {
    var filteredTickets = _tickets;

    // Apply status filter
    if (_statusFilter != null) {
      filteredTickets = filteredTickets
          .where((t) => t.status.toLowerCase() == _statusFilter!.toLowerCase())
          .toList();
    }

    // Apply priority filter
    if (_priorityFilter != null) {
      filteredTickets = filteredTickets
          .where((t) => t.priority.toLowerCase() == _priorityFilter!.toLowerCase())
          .toList();
    }

    return filteredTickets;
  }


  bool get isLoading => _isLoading;
  bool get isLoadingReplies => _isLoadingReplies;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  bool get hasMorePages => _hasMorePages;
  bool get hasMoreReplies => _hasMoreReplies;
  String? get statusFilter => _statusFilter;
  String? get priorityFilter => _priorityFilter;

  // Stats
  int get totalTickets => _tickets.length;
  int get pendingCount => _tickets.where((t) => t.status.toLowerCase() == 'pending').length;
  int get inProgressCount => _tickets.where((t) => t.status.toLowerCase() == 'in_progress' || t.status.toLowerCase() == 'in progress').length;
  int get resolvedCount => _tickets.where((t) => t.status.toLowerCase() == 'resolved' || t.status.toLowerCase() == 'closed').length;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLoadingReplies(bool value) {
    _isLoadingReplies = value;
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

  // Load all tickets
  Future<void> loadTickets({int page = 1}) async {
    _setLoading(true);
    _setError(null);

    try {
      if (supportDataSource == null) {
        _setError('Support service not available');
        _setLoading(false);
        return;
      }

      final response = await supportDataSource!.getAllTickets(page: page);

      if (response.isSuccess) {
        if (page == 1) {
          // First page - replace all data
          _tickets = response.data.tickets;
        } else {
          // Additional pages - append data
          _tickets.addAll(response.data.tickets);
        }

        _currentPage = response.data.currentPage;
        _totalPages = response.data.lastPage;
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
      _setError('Failed to load tickets: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Load more tickets (pagination)
  Future<void> loadMoreTickets() async {
    if (!_hasMorePages || _isLoading) return;
    await loadTickets(page: _currentPage + 1);
  }

  // Create new ticket
  Future<bool> createTicket({
    required String subject,
    required String category,
    required String priority,
    required String message,
    File? file,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      if (supportDataSource == null) {
        _setError('Support service not available');
        _setLoading(false);
        return false;
      }

      final response = await supportDataSource!.createTicket(
        subject: subject,
        category: category,
        priority: priority,
        message: message,
        file: file,
      );

      if (response.isSuccess && response.data != null) {
        // Add new ticket to the beginning of the list
        _tickets.insert(0, response.data!);
        _setLoading(false);
        return true;
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
      _setError('Failed to create ticket: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Load ticket details (with replies)
  Future<void> loadTicketDetails({
    required String ticketId,
    int page = 1,
  }) async {
    if (page == 1) {
      _setLoadingReplies(true);
    }
    _setError(null);

    try {
      if (supportDataSource == null) {
        _setError('Support service not available');
        _setLoadingReplies(false);
        return;
      }

      // // Set selected ticket
      // _selectedTicket = _tickets.firstWhere(
      //   (t) => t.id == ticketId,
      //   orElse: () => _tickets.first,
      // );

      final response = await supportDataSource!.getTicketDetails(
        ticketId: ticketId,
        page: page,
      );

      if (response.isSuccess) {
        if (page == 1) {
          // First page - replace all replies
           _selectedTicketData = response.data;
        _replies = response.data.replies;
        } else {
          // Additional pages - append replies
          _replies.addAll(response.data.replies);
        }

        // _currentReplyPage = response.data.currentPage;
        // _totalReplyPages = response.data.lastPage;
        // _hasMoreReplies = response.data.hasMorePages;
      }

      _setLoadingReplies(false);

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoadingReplies(false);
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoadingReplies(false);
    } catch (e) {
      _setError('Failed to load ticket details: ${e.toString()}');
      _setLoadingReplies(false);
    }
  }

  // Load more replies (pagination)
  Future<void> loadMoreReplies(String ticketId) async {
    if (!_hasMoreReplies || _isLoadingReplies) return;
    await loadTicketDetails(ticketId: ticketId, page: _currentReplyPage + 1);
  }

  // Reply to ticket
  Future<bool> replyToTicket({
    required String ticketId,
    required String message,
  }) async {
    _setError(null);

    try {
      if (supportDataSource == null) {
        _setError('Support service not available');
        return false;
      }

      final response = await supportDataSource!.replyToTicket(
        ticketId: ticketId,
        message: message,
      );

      if (response.isSuccess && response.data != null) {
        // Add new reply to the list
        _replies.add(response.data!);
       // Update ticket status in list to 'replied' if it was pending
        final ticketIndex = _tickets.indexWhere((t) => t.id == ticketId);
        if (ticketIndex != -1) {
          // Create updated ticket (you might need to update the status)
          // For now, just notify listeners
        }
        notifyListeners();
        return true;
      } else {
        _setError(response.message);
        return false;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('Failed to send reply: ${e.toString()}');
      return false;
    }
  }

  // Set filters
  void setStatusFilter(String? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void setPriorityFilter(String? priority) {
    _priorityFilter = priority;
    notifyListeners();
  }

  void clearFilters() {
    _statusFilter = null;
    _priorityFilter = null;
    notifyListeners();
  }

  // Refresh
  Future<void> refresh() async {
    await loadTickets(page: 1);
  }

  // Clear selected ticket
  void clearSelectedTicket() {
    _selectedTicketData = null;
    _replies = [];
    notifyListeners();
  }
}