class PaymentInitializationResponse {
  final String? status;
  final PaymentInitializationData data;

  PaymentInitializationResponse({
    required this.status,
    required this.data,
  });

 
  factory PaymentInitializationResponse.fromJson(Map<String, dynamic> json) {
    // Check if response has 'status' field (new payment) or direct data (existing payment)
    if (json.containsKey('data') && json['data'] is Map<String, dynamic>) {
      // Response format: { "status": "success", "data": {...} }
      return PaymentInitializationResponse(
        status: json['status'],
        data: PaymentInitializationData.fromJson(json['data']),
      );
    } else {
      // Response format: { "checkout_url": "...", "reference": "...", ... }
      // Direct data without wrapper
      return PaymentInitializationResponse(
        status: 'success', // Assume success if we got the data
        data: PaymentInitializationData.fromJson(json),
      );
    }
  }

  bool get isSuccess {
    // If status is not provided or is 'success', consider it successful
    if (status == null) return true;
    return status!.toLowerCase() == 'success';
  }
}

class PaymentInitializationData {
  final String checkoutUrl;
  final String reference;
  final double amount;
  final String message;

  PaymentInitializationData({
    required this.checkoutUrl,
    required this.reference,
    required this.amount,
    required this.message,
  });

  factory PaymentInitializationData.fromJson(Map<String, dynamic> json) {
    return PaymentInitializationData(
      checkoutUrl: json['checkout_url'] ?? '',
      reference: json['reference'] ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      message: json['message'] ?? '',
    );
  }
}