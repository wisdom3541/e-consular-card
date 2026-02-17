class NinVerification {
  final String nin;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String? photo;
  final String? signature;

  const NinVerification({
    required this.nin,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    this.photo,
    this.signature,
  });

  String get fullName {
    final parts = [firstName, middleName, lastName]
        .where((part) => part.isNotEmpty);
    return parts.join(' ');
  }
}