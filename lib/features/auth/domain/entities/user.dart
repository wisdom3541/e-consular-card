class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String nin;
  final String phone;
  final String? profession;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.nin,
    required this.phone,
    this.profession,
  });

  String get fullName => '$firstName $lastName';
}