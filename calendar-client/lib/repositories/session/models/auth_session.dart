import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/users/models/user.dart';

class AuthSession extends Equatable {
  const AuthSession({
    required this.accessToken,
    required this.user,
  });

  final String accessToken;
  final User user;

  @override
  List<Object?> get props => [accessToken, user];
}