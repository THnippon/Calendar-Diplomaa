import 'package:flutter_application_1/repositories/authentication/authentication.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

abstract interface class AbstractSessionRepository {
  Future<bool> getHasSeenWelcome();
  Future<void> completeWelcome();
  Future<AuthSession?> restoreSession();
  Future<AuthSession> signIn(LoginRequest request);
  Future<AuthSession> signUp(RegisterRequest request);
  Future<void> signOut(); 
  Future<void> setWelcomeFalse();
}