import 'package:flutter_application_1/repositories/users/models/user.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class AbstractUserRepository {

  Future<User> uploadAvatar({required XFile image});
  Future<User> updateProfile({String? bio, String? nickname});
}