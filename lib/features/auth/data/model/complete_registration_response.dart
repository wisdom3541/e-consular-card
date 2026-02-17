class CompleteRegistrationResponse {
  final String status;
  final String message;
  final CompleteRegistrationData? data;

  CompleteRegistrationResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CompleteRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return CompleteRegistrationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CompleteRegistrationData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class CompleteRegistrationData {
  final String id;
  final String email;
  final String nin;
  final String firstname;
  final String? middleName;
  final String surname;
  final String gender;
  final String birthdate;
  final String maritalStatus;
  final String? motherMaidenName;
  final String? height;
  final String? educationalQualification;
  final String? profession;
  final String? citizenBy;
  final String? residenceAddress;
  final int? countryId;
  final String phone;
  final String? meansOfIdentification;
  final String? documentIdNumber;
  final String? expiryDate;
  final String channel;
  final String regStatus;
  final String approvalStatus;
  final String createdAt;
  final String updatedAt;
  final NextOfKinData? nextOfKin;

  CompleteRegistrationData({
    required this.id,
    required this.email,
    required this.nin,
    required this.firstname,
    this.middleName,
    required this.surname,
    required this.gender,
    required this.birthdate,
    required this.maritalStatus,
    this.motherMaidenName,
    this.height,
    this.educationalQualification,
    this.profession,
    this.citizenBy,
    this.residenceAddress,
    this.countryId,
    required this.phone,
    this.meansOfIdentification,
    this.documentIdNumber,
    this.expiryDate,
    required this.channel,
    required this.regStatus,
    required this.approvalStatus,
    required this.createdAt,
    required this.updatedAt,
    this.nextOfKin,
  });

  factory CompleteRegistrationData.fromJson(Map<String, dynamic> json) {
    return CompleteRegistrationData(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nin: json['nin']?.toString() ?? '',
      firstname: json['firstname']?.toString() ?? '',
      middleName: json['middle_name']?.toString(),
      surname: json['surname']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      maritalStatus: json['marital_status']?.toString() ?? '',
      motherMaidenName: json['mother_maiden_name']?.toString(),
      height: json['height']?.toString(),
      educationalQualification: json['educational_qualification']?.toString(),
      profession: json['profession']?.toString(),
      citizenBy: json['citizen_by']?.toString(),
      residenceAddress: json['residence_address']?.toString(),
      countryId: json['country_id'] != null ? int.tryParse(json['country_id'].toString()) : null,
      phone: json['phone']?.toString() ?? '',
      meansOfIdentification: json['means_of_identification']?.toString(),
      documentIdNumber: json['document_id_number']?.toString(),
      expiryDate: json['expiry_date']?.toString(),
      channel: json['channel']?.toString() ?? '',
      regStatus: json['reg_status']?.toString() ?? '',
      approvalStatus: json['approval_status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      nextOfKin: json['next_of_kin'] != null
          ? NextOfKinData.fromJson(json['next_of_kin'])
          : null,
    );
  }

  String get fullName => '$firstname ${middleName ?? ''} $surname'.trim();
}

class NextOfKinData {
  final String id;
  final String eccUserId;
  final String firstName;
  final String? middleName;
  final String surname;
  final String phoneNumber;
  final String relationship;
  final String email;
  final String address;
  final String createdAt;
  final String updatedAt;

  NextOfKinData({
    required this.id,
    required this.eccUserId,
    required this.firstName,
    this.middleName,
    required this.surname,
    required this.phoneNumber,
    required this.relationship,
    required this.email,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NextOfKinData.fromJson(Map<String, dynamic> json) {
    return NextOfKinData(
      id: json['id']?.toString() ?? '',
      eccUserId: json['ecc_user_id']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      middleName: json['middle_name']?.toString(),
      surname: json['surname']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      relationship: json['relationship']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  String get fullName => '$firstName ${middleName ?? ''} $surname'.trim();
}