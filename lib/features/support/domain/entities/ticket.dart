import 'package:flutter/material.dart';

enum TicketCategory {
  technical,
  billing,
  account,
  cardRequest,
  general,
}

enum TicketPriority {
  low,
  medium,
  high,
  urgent,
}

enum TicketStatus {
  open,
  inProgress,
  resolved,
  closed,
}

class SupportTicket {
  final String id;
  final String subject;
  final TicketCategory category;
  final TicketPriority priority;
  final TicketStatus status;
  final String message;
  final String? attachmentPath;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const SupportTicket({
    required this.id,
    required this.subject,
    required this.category,
    required this.priority,
    required this.status,
    required this.message,
    this.attachmentPath,
    required this.createdAt,
    this.updatedAt,
  });

  String get categoryText {
    switch (category) {
      case TicketCategory.technical:
        return 'Technical';
      case TicketCategory.billing:
        return 'Billing';
      case TicketCategory.account:
        return 'Account';
      case TicketCategory.cardRequest:
        return 'Card Request';
      case TicketCategory.general:
        return 'General';
    }
  }

  String get priorityText {
    switch (priority) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
      case TicketPriority.urgent:
        return 'Urgent';
    }
  }

  String get statusText {
    switch (status) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.closed:
        return 'Closed';
    }
  }

  Color get statusColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xff1470F9);
      case TicketStatus.inProgress:
        return const Color(0xffFFA500);
      case TicketStatus.resolved:
        return const Color(0xff24985B);
      case TicketStatus.closed:
        return const Color(0xff6B7280);
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xffDBEAFE);
      case TicketStatus.inProgress:
        return const Color(0xffFFFAEB);
      case TicketStatus.resolved:
        return const Color(0xffE9F5EF);
      case TicketStatus.closed:
        return const Color(0xffF3F4F6);
    }
  }

  Color get priorityColor {
    switch (priority) {
      case TicketPriority.low:
        return const Color(0xff6B7280);
      case TicketPriority.medium:
        return const Color(0xff1470F9);
      case TicketPriority.high:
        return const Color(0xffFFA500);
      case TicketPriority.urgent:
        return const Color(0xffDC2626);
    }
  }
}