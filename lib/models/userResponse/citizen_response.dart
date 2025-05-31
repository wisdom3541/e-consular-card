import 'package:e_document_request/models/userResponse/citizen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'citizen_response.g.dart';

@JsonSerializable()
class CitizenResponse {
  final bool success;
  final Citizen citizen;
  final String fullName;

  CitizenResponse({
    required this.success,
    required this.citizen,
    required this.fullName,
  });

  factory CitizenResponse.fromJson(Map<String, dynamic> json) =>
      _$CitizenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CitizenResponseToJson(this);
}
