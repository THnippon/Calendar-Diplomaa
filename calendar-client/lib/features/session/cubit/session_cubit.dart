import 'package:flutter_application_1/features/session/cubit/session_state.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required AbstractSessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository,
  super(SessionInitial());

  final AbstractSessionRepository _sessionRepository;

  Future<void> bootstrap() async {
    emit(const SessionLoading());
    final hasSeenWelcome = await _sessionRepository.getHasSeenWelcome();

    if (!hasSeenWelcome){
      emit(const SessionFirstLaunch());
      return;
    }

    final session = await _sessionRepository.restoreSession();

    if (session == null){
      emit(const SessionUnauthenticated());
      return;
    }

    emit(SessionAuthenticated(authSession: session));
  }

  Future<void> setWelcomeFalse() async {
    await _sessionRepository.setWelcomeFalse();
  }

  Future<void> completeWelcome() async {
    await _sessionRepository.completeWelcome();
    emit(const SessionUnauthenticated());
  }

  void setAuthenticated(AuthSession session)
  {
    emit(SessionAuthenticated(authSession: session));
  }

  Future<void> signOut() async {
    emit(const SessionLoading());

    await _sessionRepository.signOut();
    emit(const SessionUnauthenticated());
  }
}