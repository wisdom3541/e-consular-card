import 'dart:ui';

class CardService {
  final String id;
  final String name;
  final String description;
  final double amount;

  const CardService({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
  });
}

class CardRequest {
  final List<CardService> services;
  final bool enableDelivery;
  final double deliveryFee;
  final String validityPeriod;

  const CardRequest({
    required this.services,
    this.enableDelivery = false,
    this.deliveryFee = 0.0,
    required this.validityPeriod,
  });

  double get serviceSubtotal {
    return services.fold(0.0, (sum, service) => sum + service.amount);
  }

  double get total {
    return serviceSubtotal + (enableDelivery ? deliveryFee : 0.0);
  }
}

// NEW: Card request status tracking
enum RequestStatus {
  pending,
  approved,
  rejected,
  processing,
}

class UserCardRequest {
  final String id;
  final String cardType;
  final String description;
  final DateTime dateSubmitted;
  final RequestStatus status;
  final double totalAmount;

  const UserCardRequest({
    required this.id,
    required this.cardType,
    required this.description,
    required this.dateSubmitted,
    required this.status,
    required this.totalAmount,
  });

  String get statusText {
    switch (status) {
      case RequestStatus.pending:
        return 'PENDING';
      case RequestStatus.approved:
        return 'SUCCESS';
      case RequestStatus.rejected:
        return 'REJECTED';
      case RequestStatus.processing:
        return 'PROCESSING';
    }
  }

  Color get statusColor {
    switch (status) {
      case RequestStatus.pending:
        return const Color(0xffFFA500); // Orange
      case RequestStatus.approved:
        return const Color(0xff24985B); // Green
      case RequestStatus.rejected:
        return const Color(0xffDC2626); // Red
      case RequestStatus.processing:
        return const Color(0xff1470F9); // Blue
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case RequestStatus.pending:
        return const Color(0xffFFFAEB);
      case RequestStatus.approved:
        return const Color(0xffE9F5EF);
      case RequestStatus.rejected:
        return const Color(0xffFEE2E2);
      case RequestStatus.processing:
        return const Color(0xffDBEAFE);
    }
  }
}