import 'package:json_annotation/json_annotation.dart';

part 'citizen.g.dart';

@JsonSerializable()
class Citizen {
  final int id;
  @JsonKey(name: 'CitizenID')
  final String citizenId;
  @JsonKey(name: 'HashedID')
  final String hashedId;

  @JsonKey(name: 'FirstName')
  final String firstName;
  @JsonKey(name: 'MiddleName')
  final String? middleName;
  @JsonKey(name: 'LastName')
  final String lastName;

  @JsonKey(name: 'BirthDate')
  final String birthDate;

  @JsonKey(name: 'Gender')
  final String gender;

  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'EmailAddress')
  final String emailAddress;

  @JsonKey(name: 'AddressofResidence')
  final String addressOfResidence;

  @JsonKey(name: 'AddressInNigeria')
  final String addressInNigeria;

  @JsonKey(name: 'StateofResidence')
  final String stateOfResidence;

  @JsonKey(name: 'CountryofResidence')
  final String countryOfResidence;

  @JsonKey(name: 'StateofOrigin')
  final String stateOfOrigin;

  @JsonKey(name: 'LGAof Origin')
  final String lgaOfOrigin;

  @JsonKey(name: 'MeansofID')
  final String meansOfID;

  @JsonKey(name: 'IDNumber')
  final String idNumber;

  @JsonKey(name: 'NOKFirstname')
  final String? nokFirstName;

  @JsonKey(name: 'NOKMiddleName')
  final String? nokMiddleName;

  @JsonKey(name: 'NOKLastName')
  final String? nokLastName;

  @JsonKey(name: 'NOKResidenceAddress')
  final String nokResidenceAddress;

  @JsonKey(name: 'NOKPhoneNumber')
  final String nokPhoneNumber;

  @JsonKey(name: 'NOKRelationship')
  final String? nokRelationship;

  @JsonKey(name: 'NOKEmail')
  final String nokEmail;

  @JsonKey(name: 'DateRegistered')
  final String dateRegistered;

  @JsonKey(name: 'PasswordUpdateDateTime')
  final String? passwordUpdateDateTime;

  @JsonKey(name: 'AdminProfileApproval')
  final String adminProfileApproval;

  @JsonKey(name: 'ProfileCompleted')
  final String profileCompleted;

  @JsonKey(name: 'SlipUpload')
  final String slipUpload;

  Citizen({
    required this.id,
    required this.citizenId,
    required this.hashedId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phoneNumber,
    required this.emailAddress,
    required this.addressOfResidence,
    required this.addressInNigeria,
    required this.stateOfResidence,
    required this.countryOfResidence,
    required this.stateOfOrigin,
    required this.lgaOfOrigin,
    required this.meansOfID,
    required this.idNumber,
    required this.nokFirstName,
    required this.nokMiddleName,
    required this.nokLastName,
    required this.nokResidenceAddress,
    required this.nokPhoneNumber,
    required this.nokRelationship,
    required this.nokEmail,
    required this.dateRegistered,
    required this.passwordUpdateDateTime,
    required this.adminProfileApproval,
    required this.profileCompleted,
    required this.slipUpload,
  });

  factory Citizen.fromJson(Map<String, dynamic> json) =>
      _$CitizenFromJson(json);

  Map<String, dynamic> toJson() => _$CitizenToJson(this);
}
