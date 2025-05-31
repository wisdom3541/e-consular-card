import 'package:json_annotation/json_annotation.dart';

part 'remove_from_cart_response.g.dart';

@JsonSerializable()
class RemoveFromCartResponse {
  final bool success;
  final String message;
  final String orderID;
  final String document;

  RemoveFromCartResponse({
    required this.success,
    required this.message,
    required this.orderID,
    required this.document,
  });

  factory RemoveFromCartResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveFromCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveFromCartResponseToJson(this);
}
