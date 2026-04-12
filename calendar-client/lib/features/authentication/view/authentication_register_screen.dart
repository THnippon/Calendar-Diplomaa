import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_event.dart';
import 'package:flutter_application_1/features/authentication/widgets/authentication_background.dart';
import 'package:flutter_application_1/features/authentication/widgets/authentication_login_form.dart';
import 'package:flutter_application_1/features/authentication/widgets/authentication_register_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationRegisterScreen extends StatelessWidget
{
  const AuthenticationRegisterScreen ({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackground(

        header: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Icon(
          Icons.app_registration_rounded,
          color: Colors.white,
          size: 38,
        ),
      ),
      const SizedBox(height: 24),
      const Text(
        'Создать аккаунт',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Станьте частью сообщества',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.4,
        ),
      ),
      const SizedBox(height: 8,)
    ],
  ),
        body: AuthenticationRegisterForm(onRegisterPressed: (request) {
          context.read<AuthenticationBloc>().add(
            AuthenticationRegister(request: request),
          );
        }),
        );
  }
}