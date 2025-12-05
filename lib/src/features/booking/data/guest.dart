class Guest {
  final String name;
  final String email;
  final String phoneNumber;
  final String? instagram;
  final String gender;
  final int age;

  Guest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.instagram,
    required this.gender,
    required this.age,
  });
}
