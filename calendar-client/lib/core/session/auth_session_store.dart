import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';
import 'package:flutter_application_1/repositories/users/models/user.dart';

class AuthSessionStore implements AbstractAuthSessionStore {
  AuthSession? _session;


  AuthSession? get session => _session;
  @override
  String? get accessToken => _session?.accessToken;
  @override
  User? get user => _session?.user;

  @override
  void setSession(AuthSession session) {
    _session = session;
  }

  @override
  void clear() {
    _session = null;
  }
  }