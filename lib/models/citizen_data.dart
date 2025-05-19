import 'package:json_annotation/json_annotation.dart';

part 'citizen_data.g.dart';

@JsonSerializable()
class CitizenData {
  final String batchid;
  final String birthcountry;
  final String birthdate; // Or DateTime if you want it parsed
  final String birthlga;
  final String birthstate;
  final String cardstatus;
  final String centralID;
  final String documentno;
  final String educationallevel;
  final String email;
  @JsonKey(name: 'emplymentstatus')
  final String employmentStatus;
  final String firstname;
  final String gender;
  final int heigth;
  final String maidenname;
  final String maritalstatus;
  final String middlename;
  final String nin;
  final String nok_address1;
  final String nok_address2;
  final String nok_firstname;
  final String nok_lga;
  final String nok_middlename;
  final String nok_postalcode;
  final String nok_state;
  final String nok_surname;
  final String nok_town;
  final String nspokenlang;
  final String ospokenlang;
  final String othername;
  final String pfirstname;
  final String photo;
  final String pmiddlename;
  final String profession;
  final String psurname;
  final String religion;
  final String residence_AdressLine1;
  final String residence_AdressLine2;
  final String residence_Town;
  final String residence_lga;
  final String residence_postalcode;
  final String residence_state;
  final String residencestatus;
  final String self_origin_lga;
  final String self_origin_place;
  final String self_origin_state;
  final String signature;
  final String surname;
  final String telephoneno;
  final String title;
  final String trackingId;
  final String CitizenID;
  final String HashedID;

  CitizenData({
    required this.batchid,
    required this.birthcountry,
    required this.birthdate,
    required this.birthlga,
    required this.birthstate,
    required this.cardstatus,
    required this.centralID,
    required this.documentno,
    required this.educationallevel,
    required this.email,
    required this.employmentStatus,
    required this.firstname,
    required this.gender,
    required this.heigth,
    required this.maidenname,
    required this.maritalstatus,
    required this.middlename,
    required this.nin,
    required this.nok_address1,
    required this.nok_address2,
    required this.nok_firstname,
    required this.nok_lga,
    required this.nok_middlename,
    required this.nok_postalcode,
    required this.nok_state,
    required this.nok_surname,
    required this.nok_town,
    required this.nspokenlang,
    required this.ospokenlang,
    required this.othername,
    required this.pfirstname,
    required this.photo,
    required this.pmiddlename,
    required this.profession,
    required this.psurname,
    required this.religion,
    required this.residence_AdressLine1,
    required this.residence_AdressLine2,
    required this.residence_Town,
    required this.residence_lga,
    required this.residence_postalcode,
    required this.residence_state,
    required this.residencestatus,
    required this.self_origin_lga,
    required this.self_origin_place,
    required this.self_origin_state,
    required this.signature,
    required this.surname,
    required this.telephoneno,
    required this.title,
    required this.trackingId,
    required this.CitizenID,
    required this.HashedID,
  });

  factory CitizenData.fromJson(Map<String, dynamic> json) => _$CitizenDataFromJson(json);
  Map<String, dynamic> toJson() => _$CitizenDataToJson(this);
}
