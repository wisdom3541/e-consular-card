// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      error: (json['error'] as num).toInt(),
      citizenId: json['CitizenID'] as String,
      hashedId: json['HashedID'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'CitizenID': instance.citizenId,
      'HashedID': instance.hashedId,
      'name': instance.name,
      'token': instance.token,
    };
