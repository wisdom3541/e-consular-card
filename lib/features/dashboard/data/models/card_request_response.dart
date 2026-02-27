class CardRequestResponse {
  final String status;
  final String message;
  final CardRequestData? data;

  CardRequestResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CardRequestResponse.fromJson(Map<String, dynamic> json) {
    return CardRequestResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CardRequestData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class CardRequestData {
  final String transactionId;
  final String? transactionKey;
  final double amount;
  final String validity;
  final List<ServiceItem> services;
  final bool isDeliveryIncluded;
  final String? deliveryCost;

  CardRequestData({
    required this.transactionId,
    this.transactionKey,
    required this.amount,
    required this.validity,
    required this.services,
    this.isDeliveryIncluded = false,
    this.deliveryCost,
  });

  factory CardRequestData.fromJson(Map<String, dynamic> json) {
    return CardRequestData(
      transactionId: json['transaction_id']?.toString() ?? '',
      transactionKey: json['transaction_key']?.toString(),
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      validity: json['validity']?.toString() ?? '',
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceItem.fromJson(e))
              .toList() ??
          [],
      isDeliveryIncluded: json['is_delivery_included'] ?? false,
       deliveryCost: json['delivery_cost']?.toString(),
    );
  }
}

class ServiceItem {
  final String id;
  final String name;
  final String servicode;
  final String description;
  final double price;
  final String validity;
  final String category;
  final String? meta;
  final String? countryId;
  final String? parcelId;
  final String createdAt;
  final String updatedAt;

  ServiceItem({
    required this.id,
    required this.name,
    required this.servicode,
    required this.description,
    required this.price,
    required this.validity,
    required this.category,
    this.meta,
    this.countryId,
    this.parcelId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      servicode: json['servicode']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      validity: json['validity']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      meta: json['meta']?.toString(),
      countryId: json['country_id']?.toString(),
      parcelId: json['parcel_id']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }
}