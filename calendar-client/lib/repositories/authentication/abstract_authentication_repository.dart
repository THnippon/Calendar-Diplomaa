import 'package:flutter_application_1/repositories/authentication/models/models.dart';
import 'package:flutter_application_1/repositories/authentication/models/refresh_request.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';

abstract interface class AbstractAuthenticationRepository {
  Future<LoginResponse> login (LoginRequest request);
  Future<LoginResponse> register (RegisterRequest request);
  Future<void> logout (RefreshRequest request);
  Future<LoginResponse> refresh (RefreshRequest request);
}