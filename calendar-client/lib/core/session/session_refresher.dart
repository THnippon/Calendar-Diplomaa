import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/core/session/abstract_session_refresher.dart';
import 'package:flutter_application_1/core/storage/tokens/abstract_token_storage.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/models/login_response.dart';
import 'package:flutter_application_1/repositories/authentication/models/refresh_request.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

class SessionRefreshser implements AbstractSessionRefresher {
  SessionRefreshser ({
    required AbstractAuthenticationRepository authenticationRepositry,
    required AbstractTokenStorage tokenStorage,
    required AbstractAuthSessionStore sessionStorage,
    }) : _authenticationRepositry = authenticationRepositry,
    _tokenStorage = tokenStorage,
    _sessionStorage = sessionStorage;

    final AbstractAuthenticationRepository _authenticationRepositry;
    final AbstractTokenStorage _tokenStorage;
    final AbstractAuthSessionStore _sessionStorage;

    @override
  Future<AuthSession?> refreshSession() async {
    final refreshToken = await _tokenStorage.readRefreshToken();

    if (refreshToken == null || refreshToken.trim().isEmpty)
    {
      _sessionStorage.clear();
      return null;
    }

    try{
      final response = await _authenticationRepositry.refresh(
        RefreshRequest(refreshToken: refreshToken)
      );

      final session = _mapLoginResponseToAuthSession(response);
      await _tokenStorage.writeRefreshToket(response.refreshToken);
      _sessionStorage.setSession(session);
      return session;
    } on DioException catch (exception){
      if (_isRefreshRejectedByServer(exception)){
        await _tokenStorage.deleteRefreshToken();
        _sessionStorage.clear();
        return null;
      }

      rethrow;
    }
  }

  AuthSession _mapLoginResponseToAuthSession(LoginResponse response) {
    return AuthSession(
      accessToken: response.accessToken,
      user: response.user,
    );
  }

  bool _isRefreshRejectedByServer(DioException exception) {
    final statusCode = exception.response?.statusCode;

    return statusCode == 400 || statusCode == 401;
  }

}