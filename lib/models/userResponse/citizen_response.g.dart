// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citizen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CitizenResponse _$CitizenResponseFromJson(Map<String, dynamic> json) =>
    CitizenResponse(
      success: json['success'] as bool,
      citizen: Citizen.fromJson(json['citizen'] as Map<String, dynamic>),
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$CitizenResponseToJson(CitizenResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'citizen': instance.citizen,
      'fullName': instance.fullName,
    };
