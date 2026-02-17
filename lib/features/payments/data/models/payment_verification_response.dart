class PaymentVerificationResponse {
  final String status;
  final String message;
  final PaymentVerificationData? data;

  PaymentVerificationResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory PaymentVerificationResponse.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PaymentVerificationData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class PaymentVerificationData {
  final String transactionId;
  final String reference;
  final double amount;
  final String paymentStatus;
  final String? transactionDate;

  PaymentVerificationData({
    required this.transactionId,
    required this.reference,
    required this.amount,
    required this.paymentStatus,
    this.transactionDate,
  });

  factory PaymentVerificationData.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationData(
      transactionId: json['transaction_id']?.toString() ?? '',
      reference: json['reference']?.toString() ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      paymentStatus: json['payment_status']?.toString() ?? '',
      transactionDate: json['transaction_date']?.toString(),
    );
  }

  bool get isPaid => paymentStatus.toLowerCase() == 'paid' ||
      paymentStatus.toLowerCase() == 'success' ||
      paymentStatus.toLowerCase() == 'successful';
}