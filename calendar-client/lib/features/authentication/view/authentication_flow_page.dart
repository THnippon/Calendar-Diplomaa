import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/dependencies.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_state.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_login_screen.dart';
import 'package:flutter_application_1/features/session/cubit/session_cubit.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationFlowPage extends StatelessWidget{
  const AuthenticationFlowPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(sessionRepository: sl<AbstractSessionRepository>()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) {
          return previous.requestStatus != current.requestStatus &&
          current.requestStatus == AuthenticationRequestStatus.success &&
          current.session != null;
        },
        listener:(context, state) {
          final session = state.session;
          if (session == null) return;
          context.read<SessionCubit>().setAuthenticated(session);
        },
        child: child,
      ),
    );
    
  }
}