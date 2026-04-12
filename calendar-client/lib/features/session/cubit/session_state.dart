import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

final class SessionInitial extends SessionState{
  const SessionInitial();
}

final class SessionLoading extends SessionState{
  const SessionLoading();
}

final class SessionFirstLaunch extends SessionState{
  const SessionFirstLaunch();
}

final class SessionUnauthenticated extends SessionState{
  const SessionUnauthenticated();
}

final class SessionAuthenticated extends SessionState{
  const SessionAuthenticated ({
    required this.authSession,
  });
  final AuthSession authSession;

  @override
  List<Object?> get props => [authSession];
}