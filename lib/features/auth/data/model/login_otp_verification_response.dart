class LoginOtpVerificationResponse {
  final String status;
  final String message;
  final LoginOtpData? data;

  LoginOtpVerificationResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory LoginOtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return LoginOtpVerificationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginOtpData.fromJson(json['data']) : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class LoginOtpData {
  final LoginUserData user;
  final String accessToken;
  final String tokenType;

  LoginOtpData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginOtpData.fromJson(Map<String, dynamic> json) {
    return LoginOtpData(
      user: LoginUserData.fromJson(json['user']),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
    );
  }
}

class LoginUserData {
  final String id;
  final String email;
  final String nin;
  final String? birthCertificate;
  final String firstname;
  final String? middleName;
  final String surname;
  final String gender;
  final String birthdate;
  final String maritalStatus;
  final int? numberOfChildren;
  final String? motherMaidenName;
  final String? height;
  final String? educationalQualification;
  final String? profession;
  final String? citizenBy;
  final String? residenceAddress;
  final int? stateId;
  final int? lgaId;
  final int? countryId;
  final String phone;
  final String? whatsapp;
  final String? foreignAddress;
  final String? meansOfIdentification;
  final String? documentIdNumber;
  final String? expiryDate;
  final String channel;
  final String regStatus;
  final String approvalStatus;
  final String? rejectionReason;
  final String createdAt;
  final String updatedAt;
  final List<UserRole>? roles;

  LoginUserData({
    required this.id,
    required this.email,
    required this.nin,
    this.birthCertificate,
    required this.firstname,
    this.middleName,
    required this.surname,
    required this.gender,
    required this.birthdate,
    required this.maritalStatus,
    this.numberOfChildren,
    this.motherMaidenName,
    this.height,
    this.educationalQualification,
    this.profession,
    this.citizenBy,
    this.residenceAddress,
    this.stateId,
    this.lgaId,
    this.countryId,
    required this.phone,
    this.whatsapp,
    this.foreignAddress,
    this.meansOfIdentification,
    this.documentIdNumber,
    this.expiryDate,
    required this.channel,
    required this.regStatus,
    required this.approvalStatus,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
    this.roles,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nin: json['nin']?.toString() ?? '',
      birthCertificate: json['birth_certificate']?.toString(),
      firstname: json['firstname']?.toString() ?? '',
      middleName: json['middle_name']?.toString(),
      surname: json['surname']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      maritalStatus: json['marital_status']?.toString() ?? '',
      numberOfChildren: json['number_of_children'] != null
          ? int.tryParse(json['number_of_children'].toString())
          : null,
      motherMaidenName: json['mother_maiden_name']?.toString(),
      height: json['height']?.toString(),
      educationalQualification: json['educational_qualification']?.toString(),
      profession: json['profession']?.toString(),
      citizenBy: json['citizen_by']?.toString(),
      residenceAddress: json['residence_address']?.toString(),
      stateId: json['state_id'] != null
          ? int.tryParse(json['state_id'].toString())
          : null,
      lgaId: json['lga_id'] != null ? int.tryParse(json['lga_id'].toString()) : null,
      countryId: json['country_id'] != null
          ? int.tryParse(json['country_id'].toString())
          : null,
      phone: json['phone']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString(),
      foreignAddress: json['foreign_address']?.toString(),
      meansOfIdentification: json['means_of_identification']?.toString(),
      documentIdNumber: json['document_id_number']?.toString(),
      expiryDate: json['expiry_date']?.toString(),
      channel: json['channel']?.toString() ?? '',
      regStatus: json['reg_status']?.toString() ?? '',
      approvalStatus: json['approval_status']?.toString() ?? '',
      rejectionReason: json['rejection_reason']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      roles: json['roles'] != null
          ? (json['roles'] as List).map((r) => UserRole.fromJson(r)).toList()
          : null,
    );
  }

  String get fullName => '$firstname ${middleName ?? ''} $surname'.trim();
}

class UserRole {
  final int id;
  final String name;
  final String displayName;
  final String? description;

  UserRole({
    required this.id,
    required this.name,
    required this.displayName,
    this.description,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
      description: json['description']?.toString(),
    );
  }
}