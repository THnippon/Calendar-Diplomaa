import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/models/login_request.dart';
import 'package:flutter_application_1/repositories/authentication/models/login_response.dart';
import 'package:flutter_application_1/repositories/authentication/models/refresh_request.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';

class AuthenticationRepository implements AbstractAuthenticationRepository
{
  const AuthenticationRepository({required Dio dio}) : _dio = dio;
  
  final Dio _dio;

  @override
  Future<LoginResponse> register(RegisterRequest request) async {
    final response = await _dio.post('/auth/register', data: request.toJson());
    final data = response.data as Map<String, dynamic>;

    return LoginResponse.fromJson(data);
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post('/auth/login', data: request.toJson());
    final data = response.data as Map<String, dynamic>;

    return LoginResponse.fromJson(data);
  }

  @override
  Future<void> logout(RefreshRequest request) async {
    await _dio.post('/auth/logout', data: request.toJson());
  }

  @override
  Future<LoginResponse> refresh(RefreshRequest request) async {
    final response = await _dio.post('/auth/refresh', data: request.toJson());
    final data = response.data as Map<String, dynamic>;

    return LoginResponse.fromJson(data);
  }
}