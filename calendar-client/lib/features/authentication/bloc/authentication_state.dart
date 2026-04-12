import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';
import 'package:flutter_application_1/repositories/session/session_repository.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

enum AuthenticationRequestStatus {
  initial,
  loading,
  failure,
  success,
}

class AuthenticationState extends Equatable{
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.requestStatus  = AuthenticationRequestStatus.initial,
    this.session,  
    this.errorMessage});

  final AuthenticationStatus status;
  final AuthenticationRequestStatus requestStatus;
  final AuthSession? session;
  final String? errorMessage;

  AuthenticationState copyWith ({
    AuthenticationStatus? status,
    AuthenticationRequestStatus? requestStatus,
    Object? session = _sentinel,
    Object? errorMessage = _sentinel,
  })
  {
    return AuthenticationState(
      status: status ?? this.status,
      requestStatus: requestStatus ?? this.requestStatus,
      session: identical(session, _sentinel) ? this.session : session as AuthSession?,
      errorMessage: identical(errorMessage, _sentinel) ? this.errorMessage : errorMessage as String?,
    );
  } 

  static const _sentinel = Object();
  
  @override
  List<Object?> get props => [status, requestStatus, session, errorMessage];
}