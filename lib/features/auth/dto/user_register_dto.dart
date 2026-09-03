import 'package:flutter_app_test/features/auth/dto/login_dto.dart';

class UserRegisterDto {
  
  final String email;
  final String password;

  const UserRegisterDto({
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  LoginDto toLoginDto() {
    return LoginDto(
      email: this.email,
      password: this.password);
  }

}