import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/core/session/abstract_session_refresher.dart';
import 'package:flutter_application_1/core/storage/tokens/token_storage.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor ({
    required AbstractAuthSessionStore authSessionStore,
    required AbstractSessionRefresher sessionRefresher,
    required Dio retryDio,
  }) : _authSessionStore = authSessionStore,
  _sessionRefresher = sessionRefresher,
  _retryDio = retryDio;

  final AbstractAuthSessionStore _authSessionStore;
  final AbstractSessionRefresher _sessionRefresher;
  final Dio _retryDio;

  Future<AuthSession?>? _refreshFuture;

  static const _publicPaths = {'/auth/login', '/auth/register', '/auth/refresh'};

  bool _isPublicPath (String path) => _publicPaths.any((p) => path.startsWith(p));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    if (_isPublicPath(options.path))
    {
      return handler.next(options);
    }
    final requiresAuth = options.extra['requiresAuth'] != true;
    final token = _authSessionStore.accessToken;

    if (requiresAuth && token != null && token.isNotEmpty)
    {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldTryRefresh(err))
    {
      handler.next(err);
      return;
    }

    try{
      final refreshedSession = await _refreshOnce();

      if (refreshedSession == null) {
        handler.next(err);
        return;
      }

      final response = await _retryRequest(requestOptions: err.requestOptions, accessToken: refreshedSession.accessToken);

      handler.resolve(response);
    } on DioException catch (retryError){
      handler.next(retryError);
    }
  }

  bool _shouldTryRefresh(DioException err){
    
    final path = err.requestOptions.path;
    final isUnauthorized = err.response?.statusCode == 401;

    return isUnauthorized && !_isPublicPath(path);
  }

  Future<AuthSession?> _refreshOnce() {
    final inFlightRequest = _refreshFuture;
    if(inFlightRequest != null){
      return inFlightRequest;
    }

    final refreshFuture = _sessionRefresher.refreshSession();

    _refreshFuture = refreshFuture.whenComplete(() {
      _refreshFuture = null;
    });

    return _refreshFuture!;
  }

  Future<Response<dynamic>> _retryRequest({
    required RequestOptions requestOptions,
    required String accessToken
  }) {
    final updatedHeaders = Map<String, dynamic>.from(requestOptions.headers)..['Authorization'] = 'Bearer $accessToken';

    final updatedExtra = Map<String, dynamic>.from(requestOptions.extra)..['authRetryAttempted'] = true;

    final retriedRequest = requestOptions.copyWith(headers: updatedHeaders, extra: updatedExtra);

    return _retryDio.fetch<dynamic>(retriedRequest);
  }

}