import 'package:json_annotation/json_annotation.dart';

part 'citizen_data.g.dart';

@JsonSerializable()
class CitizenData {
  final String? batchid;
  final String? birthcountry;
  final String? birthdate; // Use DateTime? and custom parsing if needed
  final String? birthlga;
  final String? birthstate;
  final String? cardstatus;
  final String? centralID;
  final String? documentno;
  final String? educationallevel;
  final String? email;

  @JsonKey(name: 'emplymentstatus')
  final String? employmentStatus;

  final String? firstname;
  final String? gender;
  final int? heigth;
  final String? maidenname;
  final String? maritalstatus;
  final String? middlename;
  final String? nin;

  final String? nok_address1;
  final String? nok_address2;
  final String? nok_firstname;
  final String? nok_lga;
  final String? nok_middlename;
  final String? nok_postalcode;
  final String? nok_state;
  final String? nok_surname;
  final String? nok_town;

  final String? nspokenlang;
  final String? ospokenlang;
  final String? othername;

  final String? pfirstname;
  final String? photo;
  final String? pmiddlename;
  final String? profession;
  final String? psurname;
  final String? religion;

  final String? residence_AdressLine1;
  final String? residence_AdressLine2;
  final String? residence_Town;
  final String? residence_lga;
  final String? residence_postalcode;
  final String? residence_state;
  final String? residencestatus;

  final String? self_origin_lga;
  final String? self_origin_place;
  final String? self_origin_state;

  final String? signature;
  final String? surname;
  final String? telephoneno;
  final String? title;
  final String? trackingId;
  final String? CitizenID;
  final String? HashedID;

  CitizenData({
    this.batchid,
    this.birthcountry,
    this.birthdate,
    this.birthlga,
    this.birthstate,
    this.cardstatus,
    this.centralID,
    this.documentno,
    this.educationallevel,
    this.email,
    this.employmentStatus,
    this.firstname,
    this.gender,
    this.heigth,
    this.maidenname,
    this.maritalstatus,
    this.middlename,
    this.nin,
    this.nok_address1,
    this.nok_address2,
    this.nok_firstname,
    this.nok_lga,
    this.nok_middlename,
    this.nok_postalcode,
    this.nok_state,
    this.nok_surname,
    this.nok_town,
    this.nspokenlang,
    this.ospokenlang,
    this.othername,
    this.pfirstname,
    this.photo,
    this.pmiddlename,
    this.profession,
    this.psurname,
    this.religion,
    this.residence_AdressLine1,
    this.residence_AdressLine2,
    this.residence_Town,
    this.residence_lga,
    this.residence_postalcode,
    this.residence_state,
    this.residencestatus,
    this.self_origin_lga,
    this.self_origin_place,
    this.self_origin_state,
    this.signature,
    this.surname,
    this.telephoneno,
    this.title,
    this.trackingId,
    this.CitizenID,
    this.HashedID,
  });

  factory CitizenData.fromJson(Map<String, dynamic> json) => _$CitizenDataFromJson(json);
  Map<String, dynamic> toJson() => _$CitizenDataToJson(this);
}
