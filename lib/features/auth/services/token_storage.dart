import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getToken() async {
    await _storage.read(key: 'token');
  }

  Future<String?> getRefreshToken() async {
    await _storage.read(key: 'refreshToken');
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}