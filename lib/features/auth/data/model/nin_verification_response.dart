import 'dart:convert';

class NinVerificationResponse {
  final String status;
  final String statusCode;
  final String linkEmail;
  final NinVerificationData data;

  NinVerificationResponse({
    required this.status,
    required this.statusCode,
    required this.linkEmail,
    required this.data,
  });

  factory NinVerificationResponse.fromJson(Map<String, dynamic> json) {
    // Parse the nested JSON string in the 'response' field
    final responseString = json['response'] as String;
    final responseData = jsonDecode(responseString);
    
    return NinVerificationResponse(
      status: json['status'] ?? '',
      statusCode: json['status_code'] ?? '',
      linkEmail: json['link_email'] ?? '',
      data: NinVerificationData.fromJson(responseData['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success' && statusCode == '200';
}

class NinVerificationData {
  final String nin;
  final String firstname;
  final String middlename;
  final String surname;
  final String email;
  final String telephoneno;
  final String birthdate;
  final String gender;
  final String birthstate;
  final String birthlga;
  final String birthcountry;
  final String residenceAddressline1;
  final String residenceTown;
  final String residenceLga;
  final String residenceState;
  final String maritalstatus;
  final String religion;
  final String profession;
  final String educationallevel;
  final String employmentstatus;
  final String? photo;
  final String? signature;
  
  // Next of Kin details
  final String? nokFirstname;
  final String? nokMiddlename;
  final String? nokSurname;
  final String? nokAddress1;
  final String? nokTown;
  final String? nokLga;
  final String? nokState;

  NinVerificationData({
    required this.nin,
    required this.firstname,
    required this.middlename,
    required this.surname,
    required this.email,
    required this.telephoneno,
    required this.birthdate,
    required this.gender,
    required this.birthstate,
    required this.birthlga,
    required this.birthcountry,
    required this.residenceAddressline1,
    required this.residenceTown,
    required this.residenceLga,
    required this.residenceState,
    required this.maritalstatus,
    required this.religion,
    required this.profession,
    required this.educationallevel,
    required this.employmentstatus,
    this.photo,
    this.signature,
    this.nokFirstname,
    this.nokMiddlename,
    this.nokSurname,
    this.nokAddress1,
    this.nokTown,
    this.nokLga,
    this.nokState,
  });

  factory NinVerificationData.fromJson(Map<String, dynamic> json) {
    return NinVerificationData(
      nin: json['nin']?.toString() ?? '',
      firstname: json['firstname']?.toString() ?? '',
      middlename: json['middlename']?.toString() ?? '',
      surname: json['surname']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telephoneno: json['telephoneno']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthstate: json['birthstate']?.toString() ?? '',
      birthlga: json['birthlga']?.toString() ?? '',
      birthcountry: json['birthcountry']?.toString() ?? '',
      residenceAddressline1: json['residence_adressline1']?.toString() ?? '',
      residenceTown: json['residence_town']?.toString() ?? '',
      residenceLga: json['residence_lga']?.toString() ?? '',
      residenceState: json['residence_state']?.toString() ?? '',
      maritalstatus: json['maritalstatus']?.toString() ?? '',
      religion: json['religion']?.toString() ?? '',
      profession: json['profession']?.toString() ?? '',
      educationallevel: json['educationallevel']?.toString() ?? '',
      employmentstatus: json['emplymentstatus']?.toString() ?? '', // Note: API has typo 'emplymentstatus'
      photo: json['photo']?.toString(),
      signature: json['signature']?.toString(),
      nokFirstname: json['nok_firstname']?.toString(),
      nokMiddlename: json['nok_middlename']?.toString(),
      nokSurname: json['nok_surname']?.toString(),
      nokAddress1: json['nok_address1']?.toString(),
      nokTown: json['nok_town']?.toString(),
      nokLga: json['nok_lga']?.toString(),
      nokState: json['nok_state']?.toString(),
    );
  }

  String get fullName {
    final parts = [firstname, middlename, surname]
        .where((part) => part.isNotEmpty);
    return parts.join(' ');
  }

  String get formattedBirthdate {
    try {
      // Convert from DD-MM-YYYY to YYYY-MM-DD
      final parts = birthdate.split('-');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1]}-${parts[0]}';
      }
    } catch (e) {
      // Return as is if parsing fails
    }
    return birthdate;
  }
}