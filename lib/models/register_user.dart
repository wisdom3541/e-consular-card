import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part "register_user.g.dart"; // Generated file

@JsonSerializable()
class RegisterUser {
  @JsonKey(name: 'EmailAddress')
  final String emailAddress;

  @JsonKey(name: 'nationalid')
  final String nin;

  @JsonKey(name: 'UserPassword')
  final String password;

  RegisterUser({
    required this.emailAddress,
    required this.nin,
    required this.password,
  });

  // Factory constructor for JSON parsing
  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$RegisterUserToJson(this);
}

@JsonSerializable()
class RegisterUserResponse {
  @JsonKey(name: 'success')
  final bool successMessage;

   @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'otp')
  final int? otp;

   @JsonKey(name: 'data')
 final RegisterDataResponse responseData;

  RegisterUserResponse(
      {required this.successMessage,
      required this.message,
      required this.otp,
      required this.responseData});

  // Factory constructor for JSON parsing
  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserResponseFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$RegisterUserResponseToJson(this);
}

@JsonSerializable()
class RegisterDataResponse {
  @JsonKey(name: 'CitizenID')
  final String citizenId;

  @JsonKey(name: 'HashedID')
  final String hashedId;

  @JsonKey(name: 'Email')
  final String email;

    @JsonKey(name: 'RegisteredAt')
  final String registeredAt; 

  RegisterDataResponse({
    required this.citizenId,
    required this.hashedId,
    required this.email,
    required this.registeredAt
  });

  // Factory constructor for JSON parsing
  factory RegisterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataResponseFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$RegisterDataResponseToJson(this);
}
