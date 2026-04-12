import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/authentication/authentication.dart';
import 'package:flutter_application_1/repositories/authentication/models/register_request.dart';

abstract class AuthenticationEvent extends Equatable
{
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}


class AuthenticationLogin extends AuthenticationEvent
{
  const AuthenticationLogin ({
    required this.request
  });

  final LoginRequest request;

  @override
  List<Object?> get props => [request];
}

class AuthenticationRegister extends AuthenticationEvent
{
  const AuthenticationRegister ({
    required this.request
  });

  final RegisterRequest request;

  @override
  List<Object?> get props => [request];
}