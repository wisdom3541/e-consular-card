// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVerificationResponse _$PaymentVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentVerificationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$PaymentVerificationResponseToJson(
        PaymentVerificationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'transaction_id': instance.transactionId,
    };
