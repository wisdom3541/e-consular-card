// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUser _$RegisterUserFromJson(Map<String, dynamic> json) => RegisterUser(
      emailAddress: json['EmailAddress'] as String,
      nin: json['nationalid'] as String,
      password: json['UserPassword'] as String,
    );

Map<String, dynamic> _$RegisterUserToJson(RegisterUser instance) =>
    <String, dynamic>{
      'EmailAddress': instance.emailAddress,
      'nationalid': instance.nin,
      'UserPassword': instance.password,
    };

RegisterUserResponse _$RegisterUserResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterUserResponse(
      successMessage: json['success'] as bool,
      message: json['message'] as String,
      otp: (json['otp'] as num?)?.toInt(),
      responseData:
          RegisterDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterUserResponseToJson(
        RegisterUserResponse instance) =>
    <String, dynamic>{
      'success': instance.successMessage,
      'message': instance.message,
      'otp': instance.otp,
      'data': instance.responseData,
    };

RegisterDataResponse _$RegisterDataResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterDataResponse(
      citizenId: json['CitizenID'] as String,
      hashedId: json['HashedID'] as String,
      email: json['Email'] as String,
      registeredAt: json['RegisteredAt'] as String,
    );

Map<String, dynamic> _$RegisterDataResponseToJson(
        RegisterDataResponse instance) =>
    <String, dynamic>{
      'CitizenID': instance.citizenId,
      'HashedID': instance.hashedId,
      'Email': instance.email,
      'RegisteredAt': instance.registeredAt,
    };
