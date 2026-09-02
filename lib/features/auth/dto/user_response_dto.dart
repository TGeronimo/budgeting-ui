class UserResponseDto {
  final String id;
  final String email;
  final String password;

  UserResponseDto({
    required this.id,
    required this.email,
    required this.password,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    return UserResponseDto(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}
