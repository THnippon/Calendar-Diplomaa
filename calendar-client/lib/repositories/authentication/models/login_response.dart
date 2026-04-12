import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/users/users.dart';

class LoginResponse extends Equatable
{
  const LoginResponse ({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final User user;

  @override
  List<Object?> get props => [accessToken, tokenType, refreshToken, user];

  factory LoginResponse.fromJson(Map<String, dynamic> json)
  {
    return LoginResponse(accessToken: json['accessToken'] as String,
    tokenType: json['tokenType'] as String,
    refreshToken: json['refreshToken'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}