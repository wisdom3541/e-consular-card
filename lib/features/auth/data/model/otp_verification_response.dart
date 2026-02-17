class OtpVerificationResponse {
  final String status;
  final String message;
  final OtpVerificationData? data;

  OtpVerificationResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? OtpVerificationData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class OtpVerificationData {
  final UserData user;
  final String accessToken;
  final String tokenType;

  OtpVerificationData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory OtpVerificationData.fromJson(Map<String, dynamic> json) {
    return OtpVerificationData(
      user: UserData.fromJson(json['user']),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}

class UserData {
  final String id;
  final String firstname;
  final String surname;
  final String email;
  final String nin;
  final String channel;
  final String gender;
  final String birthdate;
  final String phone;
  final String? residenceAddress;
  final String? educationalQualification;
  final String? profession;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.nin,
    required this.channel,
    required this.gender,
    required this.birthdate,
    required this.phone,
    this.residenceAddress,
    this.educationalQualification,
    this.profession,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?.toString() ?? '',
      firstname: json['firstname']?.toString() ?? '',
      surname: json['surname']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nin: json['nin']?.toString() ?? '',
      channel: json['channel']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      residenceAddress: json['residence_address']?.toString(),
      educationalQualification: json['educational_qualification']?.toString(),
      profession: json['profession']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'surname': surname,
      'email': email,
      'nin': nin,
      'channel': channel,
      'gender': gender,
      'birthdate': birthdate,
      'phone': phone,
      'residence_address': residenceAddress,
      'educational_qualification': educationalQualification,
      'profession': profession,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String get fullName => '$firstname $surname';
}