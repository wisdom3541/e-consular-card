

class NinVerificationModel {
  final bool success;
  final String message;
  final NinData? data;

  NinVerificationModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory NinVerificationModel.fromJson(Map<String, dynamic> json) {
    return NinVerificationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? NinData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class NinData {
  final String nin;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? dateOfBirth;
  final String? phoneNumber;

  NinData({
    required this.nin,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.dateOfBirth,
    this.phoneNumber,
  });

  factory NinData.fromJson(Map<String, dynamic> json) {
    return NinData(
      nin: json['nin'] ?? '',
      firstName: json['first_name'] ?? json['firstName'] ?? '',
      lastName: json['last_name'] ?? json['lastName'] ?? '',
      middleName: json['middle_name'] ?? json['middleName'],
      dateOfBirth: json['date_of_birth'] ?? json['dateOfBirth'],
      phoneNumber: json['phone_number'] ?? json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nin': nin,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
    };
  }
}