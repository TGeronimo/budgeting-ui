class RegisterResponseDto {
  final String id;
  final String email;
  final String password;

  RegisterResponseDto({
    required this.id,
    required this.email,
    required this.password,
  });

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDto(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}
