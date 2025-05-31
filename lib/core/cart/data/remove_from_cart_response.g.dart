// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_from_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveFromCartResponse _$RemoveFromCartResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveFromCartResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      orderID: json['orderID'] as String,
      document: json['document'] as String,
    );

Map<String, dynamic> _$RemoveFromCartResponseToJson(
        RemoveFromCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'orderID': instance.orderID,
      'document': instance.document,
    };
