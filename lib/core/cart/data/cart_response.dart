import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  final bool success;
  final String message;

  @JsonKey(name: 'orderID')
  final String orderId;

  final num totalAmount;

  final List<CartItem> items;

  CartResponse({
    required this.success,
    required this.message,
    required this.orderId,
    required this.totalAmount,
    required this.items,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class CartItem {
  @JsonKey(name: 'DocumentID')
  final String documentID;

  @JsonKey(name: 'DocumentName')
  final String documentName;

  @JsonKey(name: 'DocumentAmount')
  final String documentAmount;

  @JsonKey(name: 'DocumentStatus')
  final String documentStatus;

  @JsonKey(name: 'DocumentRequestDate')
  final String documentRequestDate;

  CartItem({
    required this.documentID,
    required this.documentName,
    required this.documentAmount,
    required this.documentStatus,
    required this.documentRequestDate,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}


@JsonSerializable()
class ClearCartResponse {
  final bool success;
  final String message;
  final int deletedItems;

  ClearCartResponse({
    required this.success,
    required this.message,
    required this.deletedItems,
  });

  factory ClearCartResponse.fromJson(Map<String, dynamic> json) =>
      _$ClearCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClearCartResponseToJson(this);
}
