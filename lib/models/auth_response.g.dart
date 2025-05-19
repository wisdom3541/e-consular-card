// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      errorCode: (json['error'] as num).toInt(),
      userId: (json['id'] as num).toInt(),
      name: json['name'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'error': instance.errorCode,
      'id': instance.userId,
      'name': instance.name,
      'token': instance.token,
    };
