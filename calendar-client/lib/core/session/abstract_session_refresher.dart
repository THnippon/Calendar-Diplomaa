import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

abstract interface class AbstractSessionRefresher {
  Future<AuthSession?> refreshSession();
}