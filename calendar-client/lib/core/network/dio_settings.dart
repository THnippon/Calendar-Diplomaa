import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/di/dependencies.dart';
import 'package:flutter_application_1/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/core/session/abstract_session_refresher.dart';

Dio _createDio()
{
  return Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}

Dio createMainDio()
{
  final dio = _createDio();
  dio.interceptors.add(AuthInterceptor(
    authSessionStore: sl<AbstractAuthSessionStore>(),
    sessionRefresher: sl<AbstractSessionRefresher>(),
    retryDio: dio
    ),
    );
    return dio;

}

Dio createAuthDio(){
  final dio = _createDio();
  return dio;
}