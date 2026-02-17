import 'dart:ui';

class PaymentHistoryResponse {
  final String status;
  final PaymentHistoryData data;

  PaymentHistoryResponse({
    required this.status,
    required this.data,
  });

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryResponse(
      status: json['status'] ?? '',
      data: PaymentHistoryData.fromJson(json['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class PaymentHistoryData {
  final int currentPage;
  final List<PaymentHistoryItem> payments;
  final int firstPage;
  final int lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int perPage;
  final int total;

  PaymentHistoryData({
    required this.currentPage,
    required this.payments,
    required this.firstPage,
    required this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.perPage,
    required this.total,
  });

  factory PaymentHistoryData.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryData(
      currentPage: json['current_page'] ?? 1,
      payments: (json['data'] as List<dynamic>?)
              ?.map((e) => PaymentHistoryItem.fromJson(e))
              .toList() ??
          [],
      firstPage: 1,
      lastPage: json['last_page'] ?? 1,
      nextPageUrl: json['next_page_url']?.toString(),
      prevPageUrl: json['prev_page_url']?.toString(),
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 0,
    );
  }

  bool get hasMorePages => nextPageUrl != null;
}

class PaymentHistoryItem {
  final String id;
  final String ownerType;
  final String ownerId;
  final String paymentableType;
  final String paymentableId;
  final String reference;
  final PaymentMeta meta;
  final String createdAt;
  final String updatedAt;

  PaymentHistoryItem({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.paymentableType,
    required this.paymentableId,
    required this.reference,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryItem(
      id: json['id']?.toString() ?? '',
      ownerType: json['owner_type']?.toString() ?? '',
      ownerId: json['owner_id']?.toString() ?? '',
      paymentableType: json['paymentable_type']?.toString() ?? '',
      paymentableId: json['paymentable_id']?.toString() ?? '',
      reference: json['reference']?.toString() ?? '',
      meta: PaymentMeta.fromJson(json['meta'] ?? {}),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  // Helper getters
  String get displayStatus {
    switch (meta.status.toLowerCase()) {
      case 'success':
        return 'Successful';
      case 'failed':
        return 'Failed';
      case 'pending':
        return 'Pending';
      default:
        return meta.status;
    }
  }

  Color get statusColor {
    switch (meta.status.toLowerCase()) {
      case 'success':
        return const Color(0xff24985B);
      case 'failed':
        return const Color(0xffDC2626);
      case 'pending':
        return const Color(0xffFFA500);
      default:
        return const Color(0xff6B7280);
    }
  }

  Color get statusBackgroundColor {
    switch (meta.status.toLowerCase()) {
      case 'success':
        return const Color(0xffE9F5EF);
      case 'failed':
        return const Color(0xffFEE2E2);
      case 'pending':
        return const Color(0xffFFFAEB);
      default:
        return const Color(0xffF3F4F6);
    }
  }
}

class PaymentMeta {
  final String status;
  final List<String> transactionIds;
  final double amount;
  final List<String> services;
  final String checkoutUrl;
  final bool paidDelivery;
  final String? verifiedAt;
  final String transactionStatus;

  PaymentMeta({
    required this.status,
    required this.transactionIds,
    required this.amount,
    required this.services,
    required this.checkoutUrl,
    required this.paidDelivery,
    this.verifiedAt,
    required this.transactionStatus,
  });

  factory PaymentMeta.fromJson(Map<String, dynamic> json) {
    return PaymentMeta(
      status: json['status']?.toString() ?? '',
      transactionIds: (json['transaction_ids'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      checkoutUrl: json['checkout_url']?.toString() ?? '',
      paidDelivery: json['paid_delivery'] ?? false,
      verifiedAt: json['verified_at']?.toString(),
      transactionStatus: json['transaction_status']?.toString() ?? '',
    );
  }

  String get servicesDisplay => services.join(', ');
}