class RegistrationResponse {
  final String status;
  final String message;
  final RegistrationData? data;

  RegistrationResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null 
          ? RegistrationData.fromJson(json['data']) 
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class RegistrationData {
  final int otpReference;

  RegistrationData({
    required this.otpReference,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
      otpReference: json['otp_reference'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp_reference': otpReference,
    };
  }
}