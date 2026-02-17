class LoginResponse {
  final String status;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class LoginData {
  final String email;
  final int otpReference;

  LoginData({
    required this.email,
    required this.otpReference,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      email: json['email'] ?? '',
      otpReference: json['otp_reference'] ?? 0,
    );
  }
}