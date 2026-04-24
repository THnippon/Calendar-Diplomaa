import 'package:flutter_application_1/core/services/image_picker_service.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_state.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit ({
    required AbstractAuthSessionStore sessionStore,
  }) : _sessionStore = sessionStore,

  super(const ProfileState());

  final AbstractAuthSessionStore _sessionStore;


  void loadProfile() {
    emit(state.copyWith(errorMessage: null, status: ProfileStatus.loading));

    final user = _sessionStore.user;

    if (user == null)
    {
      emit(state.copyWith(errorMessage: 'Пользователь не найден', status: ProfileStatus.failure));
      return;
    }

    emit(state.copyWith(errorMessage: null, status: ProfileStatus.success, user: user));
  }
}