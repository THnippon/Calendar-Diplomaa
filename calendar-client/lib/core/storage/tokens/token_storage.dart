import 'package:flutter_application_1/core/storage/tokens/abstract_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage implements AbstractTokenStorage {
  TokenStorage ({
    FlutterSecureStorage? secureStorage
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const String _refreshTokenKey = 'auth.refresh_token';
  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> writeRefreshToket(String token) {
    return _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<String?> readRefreshToken() {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() {
    return _secureStorage.delete(key: _refreshTokenKey);
  }
}