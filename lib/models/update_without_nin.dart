import 'package:json_annotation/json_annotation.dart';

part 'update_without_nin.g.dart';

@JsonSerializable()
class UpdateWithoutNin {
  @JsonKey(name: "hashedID")
  final String hashedID;

  @JsonKey(name: "FirstName")
  final String firstName;

  @JsonKey(name: "MiddleName")
  final String middleName;

  @JsonKey(name: "LastName")
  final String lastName;

  @JsonKey(name: "BirthDate")
  final String birthDate;

  @JsonKey(name: "Gender")
  final String gender;

  @JsonKey(name: "PhoneNumber")
  final String phoneNumber;

  @JsonKey(name: "IDNumber")
  final String idNumber;

  @JsonKey(name: "StateofOrigin")
  final String stateofOrigin;

  @JsonKey(name: "LGAOfOrigin")
  final String lgaOfOrigin;

  @JsonKey(name: "AddressofResidence")
  final String addressofResidence;

  @JsonKey(name: "AddressInNigeria")
  final String addressInNigeria;

  @JsonKey(name: "StateofResidence")
  final String stateofResidence;

  @JsonKey(name: "CountryofResidence")
  final String countryofResidence;

  @JsonKey(name: "MeansofID")
  final String meansofID;

  @JsonKey(name: "NOKFirstname")
  final String nokFirstname;

  @JsonKey(name: "NOKMiddlename")
  final String nokMiddlename;

  @JsonKey(name: "NOKLastName")
  final String nokLastName;

  @JsonKey(name: "NOKResidenceAddress")
  final String nokResidenceAddress;

  @JsonKey(name: "NOKPhoneNumber")
  final String nokPhoneNumber;

  @JsonKey(name: "NOKRelationship")
  final String nokRelationship;

  @JsonKey(name: "NOKEmail")
  final String nokEmail;

  UpdateWithoutNin({
    required this.hashedID,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phoneNumber,
    required this.idNumber,
    required this.stateofOrigin,
    required this.lgaOfOrigin,
    required this.addressofResidence,
    required this.addressInNigeria,
    required this.stateofResidence,
    required this.countryofResidence,
    required this.meansofID,
    required this.nokFirstname,
    required this.nokMiddlename,
    required this.nokLastName,
    required this.nokResidenceAddress,
    required this.nokPhoneNumber,
    required this.nokRelationship,
    required this.nokEmail,
  });

  factory UpdateWithoutNin.fromJson(Map<String, dynamic> json) =>
      _$UpdateWithoutNinFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWithoutNinToJson(this);
}
