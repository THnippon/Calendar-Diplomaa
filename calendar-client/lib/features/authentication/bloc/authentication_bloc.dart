import 'package:flutter_application_1/features/authentication/bloc/authentication_event.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_state.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/models/login_response.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_application_1/repositories/session/models/auth_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
{
  AuthenticationBloc({
    required AbstractSessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository,
  super(AuthenticationState()){
    on<AuthenticationRegister>(_onAuthenticationRegisterRequest);
    on<AuthenticationLogin>(_onAuthenticationLoginRequest);
  }

  final AbstractSessionRepository _sessionRepository;

  Future<void> _onAuthenticationRegisterRequest(
    AuthenticationRegister event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _performAuthRequest(
      () => _sessionRepository.signUp(event.request),
      emit
    );
  }

  Future<void> _onAuthenticationLoginRequest(
    AuthenticationLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _performAuthRequest(
      () => _sessionRepository.signIn(event.request),
      emit
    );
  }

  Future<void> _performAuthRequest(
    Future<AuthSession> Function() request,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(
        requestStatus: AuthenticationRequestStatus.loading,
        session: null,
        errorMessage: null,
      ),
    );
    try
    {
      final session = await request();

      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticated,
          requestStatus: AuthenticationRequestStatus.success,
          session: session,
          errorMessage: null,
        ),
      );
    } catch (error)
    {
      emit(
        state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          requestStatus: AuthenticationRequestStatus.failure,
          session: null,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}