import 'package:dio/dio.dart';
import 'package:flutter_app_test/features/auth/dto/login_dto.dart';
import 'package:flutter_app_test/features/auth/dto/login_response_dto.dart';
import 'package:flutter_app_test/features/auth/dto/user_register_dto.dart';
import 'package:flutter_app_test/features/auth/dto/register_response_dto.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<RegisterResponseDto> register(UserRegisterDto dto) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: dto.toJson(),
      );

      return RegisterResponseDto.fromJson(response.data);

    } on DioException catch (e) {
      throw Exception('Erro ao registrar usuário: ${e.message}');
    }
  }

  Future<LoginResponseDto> login(LoginDto dto) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: dto.toJson()
      );
      
      return LoginResponseDto.fromJson(response.data);
      
    } on DioException catch (e) {
      throw Exception('Erro ao fazer login: ${e.message}');
    }

  }
}
