import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final int error;
  @JsonKey(name: 'CitizenID')
  final String citizenId;
  @JsonKey(name: 'HashedID')
  final String hashedId;
  final String name;
  final String token;

  LoginResponse({
    required this.error,
    required this.citizenId,
    required this.hashedId,
    required this.name,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
