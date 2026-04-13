import 'package:flutter_application_1/repositories/users/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  uploadingUserAvatar,
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    User? user,
    String? errorMessage,
  }) = _ProfileState;


}