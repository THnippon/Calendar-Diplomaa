import 'package:flutter_application_1/repositories/session/models/auth_session.dart';
import 'package:flutter_application_1/repositories/users/models/user.dart';

abstract interface class AbstractAuthSessionStore {

  String? get accessToken;
  User? get user;

  void setSession(AuthSession session);
  void clear();
}