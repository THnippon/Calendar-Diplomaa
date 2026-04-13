import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/repositories/users/abstract_user_repository.dart';
import 'package:flutter_application_1/repositories/users/models/models.dart';

class UserRepository implements AbstractUserRepository {
  const UserRepository({
    required Dio dio,
    required AbstractAuthSessionStore sessionStore,
  }) : _dio = dio,
  _sessionStore = sessionStore;

  final Dio _dio;
  final AbstractAuthSessionStore _sessionStore;

  @override
  Future<User> uploadAvatar({required XFile image}) async {
    final data = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        image.path,
        filename: image.name
      ),
    }
    );

    final response = await _dio.put('', data: data);

    return User.fromJson(response.data!);
  }

  @override
  Future<User> updateProfile({String? bio, String? nickname}) async {
    final data = <String, dynamic>{};
    if(nickname != null) data['nickname'] = nickname;
    if(bio != null) data['bio'] = bio;

    final response = await _dio.put('', data: data);

    return User.fromJson(response.data);
  }
}