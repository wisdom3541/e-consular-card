import 'package:json_annotation/json_annotation.dart';

part "auth_response.g.dart" ;// Generated file

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: 'error')
  final int errorCode;

  @JsonKey(name: 'id')
  final int userId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'token')
  final String token;

  AuthResponse({
    required this.errorCode,
    required this.userId,
    required this.name,
    required this.token,
  });

  // Factory constructor for JSON parsing
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}