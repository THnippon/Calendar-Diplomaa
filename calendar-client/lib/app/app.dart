import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/dependencies.dart';
import 'package:flutter_application_1/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_flow_page.dart';
import 'package:flutter_application_1/features/authentication/view/authentication_welcome_screen.dart';
import 'package:flutter_application_1/features/calendar/view/calendar_page.dart';
import 'package:flutter_application_1/features/session/cubit/session_cubit.dart';
import 'package:flutter_application_1/features/session/cubit/session_state.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_application_1/router/app_router.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';


class App extends StatefulWidget {
  const App ({
    super.key
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late final SessionCubit _sessionCubit;
  late final AppRouter _appRouter;

  @override void initState() {
    super.initState();

    _sessionCubit = SessionCubit(sessionRepository: sl<AbstractSessionRepository>());
    _appRouter = AppRouter(sessionCubit: _sessionCubit);

    _sessionCubit.bootstrap();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _sessionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _sessionCubit,
      child: AppView(router: _appRouter.router),
    );
  }
  }


class AppView extends StatelessWidget{
  const AppView({
    super.key,
    required this.router
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      locale: const Locale('ru', 'RU'),
      supportedLocales: const [
        Locale('ru', 'RU')
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Calendar App',
      theme: lightTheme,
    );
  }

}

