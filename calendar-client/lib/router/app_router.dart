import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_flow_page.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_login_screen.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_register_screen.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_welcome_screen.dart';
import 'package:flutter_application_1/features/calendar/calendar.dart';
import 'package:flutter_application_1/features/session/cubit/session_cubit.dart';
import 'package:flutter_application_1/features/session/cubit/session_state.dart';
import 'package:flutter_application_1/router/app_page_transition.dart';
import 'package:flutter_application_1/router/app_rout_paths.dart';
import 'package:flutter_application_1/router/session_router_notifier.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter ({
    required SessionCubit sessionCubit,
  }) : _sessionCubit = sessionCubit,
  _refreshNotifier = SessionRouterNotifier(sessionCubit: sessionCubit);


  final SessionCubit _sessionCubit;
  final SessionRouterNotifier _refreshNotifier;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splash,
    refreshListenable: _refreshNotifier,
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.welcome,
        pageBuilder: (context, state) => AppPageTransitions.slideFade<void>(
          key: state.pageKey,
          child: AuthenticationWelcomeScreen(
            onStartPressed: () {
              _sessionCubit.completeWelcome();
            },
          ),
          ),
        ),
      
      ShellRoute(
        builder: (context, state, child) {
          return AuthenticationFlowPage(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutePaths.login,
            pageBuilder: (context, state) => AppPageTransitions.slideFade<void>(
              key: state.pageKey,
              child: const AuthenticationLoginScreen()),
          ),
          GoRoute(
            path: AppRoutePaths.register,
            pageBuilder: (context, state) => AppPageTransitions.slideFade<void>(
              key: state.pageKey,
              child: const AuthenticationRegisterScreen()),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.calendar,
        pageBuilder: (context, state) => AppPageTransitions.slideFade<void>(
              key: state.pageKey,
              child: const CalendarPage()),
      ),
    ],
    redirect:(context, state) {
      final sessionState = _sessionCubit.state;
      final location = state.matchedLocation;

      final isOnSplash = location == AppRoutePaths.splash;
      final isOnWelcome = location == AppRoutePaths.welcome;
      final isOnLogin = location == AppRoutePaths.login;
      final isOnRegister = location == AppRoutePaths.register;
      final isOnCalendar = location == AppRoutePaths.calendar;
      final isInAuth = isOnLogin || isOnRegister;

      return switch (sessionState) {
        SessionInitial() || SessionLoading() => isOnSplash ? null : AppRoutePaths.splash,
        SessionFirstLaunch() => isOnWelcome ? null : AppRoutePaths.welcome,
        SessionUnauthenticated() => isInAuth ? null : AppRoutePaths.login,
        SessionAuthenticated() => isOnCalendar ? null : AppRoutePaths.calendar,
      };
    },
  );

  void dispose() {
    router.dispose();
    _refreshNotifier.dispose();
  }
}

class _SplashScreen extends StatelessWidget{
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}