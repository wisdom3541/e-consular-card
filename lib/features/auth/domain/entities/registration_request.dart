// Registration data we send to API
class RegistrationRequest {
  final String email;
  final String password;
  final String? nin;
  final String? birthCertificatePath;
  final String? birthCertificateFileName;

  const RegistrationRequest({
    required this.email,
    required this.password,
    this.nin,
    this.birthCertificatePath,
    this.birthCertificateFileName,
  });

  // Helper to check registration type
  bool get isNinRegistration => nin != null;
}