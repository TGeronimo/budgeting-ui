import 'package:dio/dio.dart';
import 'package:flutter_app_test/features/auth/dto/user_register_dto.dart';
import 'package:flutter_app_test/features/auth/dto/user_response_dto.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<UserResponseDto> register(UserRegisterDto dto) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: dto.toJson(),
      );

      // Se chegou aqui, o back-end respondeu 200 ou 201
      return UserResponseDto.fromJson(response.data);

    } on DioException catch (e) {
      // Aqui você trata erros do servidor
      throw Exception('Erro ao registrar usuário: ${e.message}');
    }
  }
}
