import 'package:equatable/equatable.dart';

class User extends Equatable
{
  const User ({
    required this.id,
    required this.email,
    required this.nickname,
    this.bio,
    this.avatarUrl,
    required this.createdAt
  });

  final int id;
  final String email;
  final String nickname;
  final String? bio;
  final String? avatarUrl;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, email, nickname, bio, avatarUrl, createdAt];

  factory User.fromJson(Map<String, dynamic> json)
  {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(['createdAt'] as String)
      );
  }
}