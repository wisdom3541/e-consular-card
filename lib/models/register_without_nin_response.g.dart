// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_without_nin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterWithoutNinResponse _$RegisterWithoutNinResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterWithoutNinResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      otp: (json['otp'] as num).toInt(),
      data: RegisterWithoutNinUserData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterWithoutNinResponseToJson(
        RegisterWithoutNinResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otp': instance.otp,
      'data': instance.data,
    };

RegisterWithoutNinUserData _$RegisterWithoutNinUserDataFromJson(
        Map<String, dynamic> json) =>
    RegisterWithoutNinUserData(
      citizenId: json['CitizenID'] as String,
      hashedId: json['HashedID'] as String,
      email: json['Email'] as String,
    );

Map<String, dynamic> _$RegisterWithoutNinUserDataToJson(
        RegisterWithoutNinUserData instance) =>
    <String, dynamic>{
      'CitizenID': instance.citizenId,
      'HashedID': instance.hashedId,
      'Email': instance.email,
    };
