import 'package:json_annotation/json_annotation.dart';

part 'payment_verification_response.g.dart';

@JsonSerializable()
class PaymentVerificationResponse {
  final bool success;
  final String message;

  @JsonKey(name: 'transaction_id')
  final String? transactionId;

  PaymentVerificationResponse({
    required this.success,
    required this.message,
    required this.transactionId,
  });

  factory PaymentVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVerificationResponseToJson(this);
}
