// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      orderId: json['orderID'] as String?,
      totalAmount: json['totalAmount'] as num?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      cart: json['cart'] as List<dynamic>?,
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'orderID': instance.orderId,
      'totalAmount': instance.totalAmount,
      'items': instance.items,
      'cart': instance.cart,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      documentID: json['DocumentID'] as String,
      documentName: json['DocumentName'] as String,
      documentAmount: json['DocumentAmount'] as String,
      documentStatus: json['DocumentStatus'] as String,
      documentRequestDate: json['DocumentRequestDate'] as String,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'DocumentID': instance.documentID,
      'DocumentName': instance.documentName,
      'DocumentAmount': instance.documentAmount,
      'DocumentStatus': instance.documentStatus,
      'DocumentRequestDate': instance.documentRequestDate,
    };

ClearCartResponse _$ClearCartResponseFromJson(Map<String, dynamic> json) =>
    ClearCartResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      deletedItems: (json['deletedItems'] as num).toInt(),
    );

Map<String, dynamic> _$ClearCartResponseToJson(ClearCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'deletedItems': instance.deletedItems,
    };
