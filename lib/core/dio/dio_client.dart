import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_test/features/auth/services/auth_interceptor.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';

class DioClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  DioClient(this.tokenStorage)
    : dio = Dio(
        BaseOptions(
          baseUrl: _getBaseUrl(),
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            },
          ),
        ) {
          // Interceptor de log
          dio.interceptors.add(
            LogInterceptor(
              requestBody: true,
              responseBody: true,
            ),
          );
          // Interceptor de tokens
          dio.interceptors.add(
            AuthInterceptor(
              tokenStorage, 
              dio)
          );
        }

  static String _getBaseUrl() {
    if(kIsWeb) {
      return  'http://localhost:8081';
    }

    if (Platform.isAndroid) {
      return 'http://localhost:8080';
    }

    return 'http://localhost:8081';
  }
}