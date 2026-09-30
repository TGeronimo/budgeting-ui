import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_test/app/session_manager.dart';
import 'package:flutter_app_test/features/auth/dto/login_response_dto.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Dio dio;

  AuthInterceptor(this.tokenStorage, this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenStorage.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;

    final isAuthRoute = path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh');

    // 1. Se for erro de rotas de auth OU não for 401, apenas repassa o erro normalmente
    if (err.response?.statusCode != 401 || isAuthRoute) {
      handler.next(err);
      return;
    }

    try {
      // 2. Tenta renovar o token
      final newTokens = await _refreshToken();

      // 3. Salva os novos tokens
      await tokenStorage.saveAccessToken(newTokens.accessToken);
      await tokenStorage.saveRefreshToken(newTokens.refreshToken);

      // 4. Clona as opções da requisição original
      final originalRequest = err.requestOptions;

      // 5. Atualiza o header com o novo token
      originalRequest.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';

      // 6. SE a requisição continha FormData, clonamos os dados para reabrir a stream do arquivo
      if (originalRequest.data is FormData) {
        originalRequest.data = await _cloneFormData(originalRequest.data as FormData);
      }

      // 7. Reenvia a requisição original
      final response = await dio.fetch(originalRequest);

      // 8. Retorna a nova resposta
      handler.resolve(response);

    } catch (e) {
      // Caso falhe o refresh, limpa os tokens e notifica a expiração da sessão
      await tokenStorage.clear();
      SessionManager.instance.notifySessionExpired();
      handler.next(err);
    }
  }

  /// Função auxiliar para clonar o FormData e recriar os MultipartFiles
  Future<FormData> _cloneFormData(FormData formData) async {
    final clonedFormData = FormData();

    // Clona os campos de texto
    clonedFormData.fields.addAll(formData.fields);

    // Reabre e clona os arquivos do FormData
    for (final file in formData.files) {
      final originalFile = file.value;
      clonedFormData.files.add(
        MapEntry(file.key, originalFile.clone()),
      );
    }

    return clonedFormData;
  }

  Future<LoginResponseDto> _refreshToken() async {
  final refreshToken = await tokenStorage.getRefreshToken();
  debugPrint('Refresh token: $refreshToken');

  final response = await dio.post(
    '/auth/refresh',
    data: {
      'refreshToken': refreshToken,
    },
  );

  return LoginResponseDto.fromJson(response.data);
  }
  
}