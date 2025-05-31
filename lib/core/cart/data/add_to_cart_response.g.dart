// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) =>
    AddToCartResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      orderID: json['orderID'] as String,
      document: json['document'] as String,
    );

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'orderID': instance.orderID,
      'document': instance.document,
    };
