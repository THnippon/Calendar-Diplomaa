import 'package:equatable/equatable.dart';

class User extends Equatable
{
  const User ({
    required this.id,
    required this.email,
    required this.nickname,
  });

  final int id;
  final String email;
  final String nickname;

  @override
  List<Object?> get props => [id, email, nickname];

  factory User.fromJson(Map<String, dynamic> json)
  {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      nickname: json['nickname'] as String
      );
  }
}