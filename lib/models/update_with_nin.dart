import 'package:json_annotation/json_annotation.dart';

part 'update_with_nin.g.dart'; // Generated file

@JsonSerializable()
class UpdateWithNin {
 final String hashedID;
  final String FirstName;
  final String MiddleName;
  final String? LastName;
  final String BirthDate;
  final String Gender;
  final String PhoneNumber;
  final String AddressofResidence;
  final String AddressInNigeria;
  final String StateofResidence;
  final String CountryofResidence;
  final String MeansofID;
  final String NOKFirstname;
  final String NOKMiddlename;
  final String NOKLastName;
  final String NOKResidenceAddress;
  final String NOKPhoneNumber;
  final String NOKRelationship;
  final String NOKEmail;
  final String? passport;
  

  UpdateWithNin({
    required this.hashedID,
    required this.FirstName,
    required this.MiddleName,
     this.LastName,
    required this.BirthDate,
    required this.Gender,
    required this.PhoneNumber,
    required this.AddressofResidence,
    required this.AddressInNigeria,
    required this.StateofResidence,
    required this.CountryofResidence,
    required this.MeansofID,
    required this.NOKFirstname,
    required this.NOKMiddlename,
    required this.NOKLastName,
    required this.NOKResidenceAddress,
    required this.NOKPhoneNumber,
    required this.NOKRelationship,
    required this.NOKEmail,
     this.passport,
  });

  factory UpdateWithNin.fromJson(Map<String, dynamic> json) => _$UpdateWithNinFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateWithNinToJson(this);
}
