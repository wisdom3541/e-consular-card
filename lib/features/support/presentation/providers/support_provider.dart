import 'package:flutter/foundation.dart';
import '../../domain/entities/ticket.dart';

class SupportProvider extends ChangeNotifier {
  List<SupportTicket> _tickets = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<SupportTicket> get tickets => _tickets;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasTickets => _tickets.isNotEmpty;

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
Future<void> loadTickets() async {
  _setLoading(true);
  _setError(null);

  try {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock data with different statuses and priorities
    _tickets = [
      SupportTicket(
        id: '17704065700058',
        subject: 'test',
        category: TicketCategory.billing,
        priority: TicketPriority.high,
        status: TicketStatus.open,
        message: 'I have an issue with my recent payment transaction. The amount was deducted but the card request is not showing in my dashboard.',
        createdAt: DateTime(2026, 2, 6, 20, 36),
      ),
      SupportTicket(
        id: '17704065700057',
        subject: 'Card delivery status',
        category: TicketCategory.cardRequest,
        priority: TicketPriority.medium,
        status: TicketStatus.inProgress,
        message: 'When will my card be delivered? It has been approved for 3 days.',
        createdAt: DateTime(2026, 2, 5, 14, 20),
      ),
      SupportTicket(
        id: '17704065700056',
        subject: 'Password reset not working',
        category: TicketCategory.technical,
        priority: TicketPriority.urgent,
        status: TicketStatus.resolved,
        message: 'I am unable to reset my password. The reset link expires immediately.',
        createdAt: DateTime(2026, 2, 4, 9, 15),
      ),
    ];

    _setLoading(false);
  } catch (e) {
    _setError('Failed to load tickets: ${e.toString()}');
    _setLoading(false);
  }
}

  Future<bool> createTicket({
    required String subject,
    required TicketCategory category,
    required TicketPriority priority,
    required String message,
    String? attachmentPath,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      // Create new ticket
      final newTicket = SupportTicket(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        subject: subject,
        category: category,
        priority: priority,
        status: TicketStatus.open,
        message: message,
        attachmentPath: attachmentPath,
        createdAt: DateTime.now(),
      );

      _tickets.insert(0, newTicket);
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to create ticket: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  void refresh() {
    loadTickets();
  }
}