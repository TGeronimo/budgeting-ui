class LoginResponseDto {
  final String token;
  final String refreshToken;

  LoginResponseDto({
    required this.token,
    required this.refreshToken
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      token: json["token"],
      refreshToken: json["refreshToken"]
    );
  }
}