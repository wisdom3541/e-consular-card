import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_response.g.dart';

@JsonSerializable()
class AddToCartResponse {
  final bool success;
  final String message;
  final String orderID;
  final String document;

  AddToCartResponse({
    required this.success,
    required this.message,
    required this.orderID,
    required this.document,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddToCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}
