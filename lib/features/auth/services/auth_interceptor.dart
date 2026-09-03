import 'package:dio/dio.dart';
import 'package:flutter_app_test/features/auth/dto/login_response_dto.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Dio dio;

  AuthInterceptor(this.tokenStorage, this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = tokenStorage.getAccessToken();

    if (accessToken == null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Se não for 401, apenas repasse o erro
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    try {
      // 1. Tenta renovar o token
      final newTokens = await _refreshToken();

      // 2. Salva os novos tokens
      await tokenStorage.saveAccessToken(newTokens.accessToken);
      await tokenStorage.saveRefreshToken(newTokens.refreshToken);

      // 3. Clona a requisição original
      final originalRequest = err.requestOptions;

      // 4. Atualiza o header com o novo token
      originalRequest.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';

      // 5. Reenvia a requisição original
      final response = await dio.fetch(originalRequest);

      // 6. Retorna a nova resposta
      handler.resolve(response);
    } catch (e) {
      // Se falhar, o usuário precisa logar de novo
      handler.next(err);
    }
  }

  Future<LoginResponseDto> _refreshToken() async {
  final refreshToken = await tokenStorage.getRefreshToken();

  final response = await dio.post(
    '/auth/refresh',
    data: {
      'refreshToken': refreshToken,
    },
  );

  return LoginResponseDto.fromJson(response.data);
  }
  
}