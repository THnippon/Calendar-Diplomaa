import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.nickname,
  });

  final String email;
  final String password;
  final String nickname;

  Map<String, dynamic> toJson()
  {
    return {
      'nickname': nickname,
      'email': email,
      'password': password,

    };
  }

  @override
  List<Object?> get props => [nickname, email, password];

}