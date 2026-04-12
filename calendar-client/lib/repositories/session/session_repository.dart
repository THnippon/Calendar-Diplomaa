import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/core/storage/launch_flags/abstract_launch_flags_storage.dart';
import 'package:flutter_application_1/core/storage/tokens/abstract_token_storage.dart';
import 'package:flutter_application_1/core/storage/tokens/token_storage.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/authentication.dart';
import 'package:flutter_application_1/repositories/authentication/authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/models/login_request.dart';
import 'package:flutter_application_1/repositories/authentication/models/refresh_request.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

class SessionRepository implements AbstractSessionRepository {
  SessionRepository ({
    required AbstractAuthenticationRepository authenticationRepository,
    required AbstractTokenStorage tokenStorage,
    required AbstractLaunchFlagsStorage launchFlagsStorage,
    required AbstractAuthSessionStore sessionStore,
  }) : _authenticationRepository = authenticationRepository,
      _tokenStorage = tokenStorage,
      _launchFlagsStorage = launchFlagsStorage,
      _sessionStore = sessionStore;


  final AbstractAuthenticationRepository _authenticationRepository;
  final AbstractTokenStorage _tokenStorage;
  final AbstractLaunchFlagsStorage _launchFlagsStorage;
  final AbstractAuthSessionStore _sessionStore;

  @override
  Future<void> completeWelcome() {
    return _launchFlagsStorage.setHasSeenWelcome(true);
  }

  @override
  Future<void> setWelcomeFalse(){
    return _launchFlagsStorage.setHasSeenWelcome(false);
  }

  @override
  Future<bool> getHasSeenWelcome() async {
    return await _launchFlagsStorage.getHasSeenWelcome();
  }

  @override
  Future<AuthSession> signIn(LoginRequest request) async {
    final response = await _authenticationRepository.login(request);

    await _tokenStorage.writeRefreshToket(response.refreshToken);
    final session = _mapLoginResponseToAuthSession(response);
    _sessionStore.setSession(session);
    return session; 
  }

  @override
  Future<AuthSession> signUp(RegisterRequest request) async {
    final response = await _authenticationRepository.register(request);

    await _tokenStorage.writeRefreshToket(response.refreshToken);
    final session = _mapLoginResponseToAuthSession(response);
    _sessionStore.setSession(session);
    return session;
  }

  AuthSession _mapLoginResponseToAuthSession(LoginResponse response)
  {
    return AuthSession(accessToken: response.accessToken, user: response.user);
  }

  @override
  Future<void> signOut() async {
    final refreshToken = await _tokenStorage.readRefreshToken();

    try{
      if (refreshToken != null && refreshToken.trim().isNotEmpty)
      {
        await _authenticationRepository.logout(RefreshRequest(refreshToken: refreshToken));
      }
    } finally {
        _tokenStorage.deleteRefreshToken();
        _sessionStore.clear();
      }
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final refreshToken = await _tokenStorage.readRefreshToken();

    if (refreshToken == null || refreshToken.trim().isEmpty)
    {
      return null;
    }
    try{
      final response = await _authenticationRepository.refresh(RefreshRequest(refreshToken: refreshToken));

      await _tokenStorage.writeRefreshToket(response.refreshToken);

      return _mapLoginResponseToAuthSession(response);
    } catch (_){
      await _tokenStorage.deleteRefreshToken();
      return null;
    }
  }
}