import 'package:json_annotation/json_annotation.dart';

part 'register_without_nin_response.g.dart';

@JsonSerializable()
class RegisterWithoutNinResponse {
  final bool success;
  final String message;
  final int otp;
  final RegisterWithoutNinUserData data;

  RegisterWithoutNinResponse({
    required this.success,
    required this.message,
    required this.otp,
    required this.data,
  });

  factory RegisterWithoutNinResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterWithoutNinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterWithoutNinResponseToJson(this);
}

@JsonSerializable()
class RegisterWithoutNinUserData {
  @JsonKey(name: 'CitizenID')
  final String citizenId;

  @JsonKey(name: 'HashedID')
  final String hashedId;

  @JsonKey(name: 'Email')
  final String email;

  RegisterWithoutNinUserData({
    required this.citizenId,
    required this.hashedId,
    required this.email,
  });

  factory RegisterWithoutNinUserData.fromJson(Map<String, dynamic> json) =>
      _$RegisterWithoutNinUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterWithoutNinUserDataToJson(this);
}
