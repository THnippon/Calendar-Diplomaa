import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/core/session/abstract_session_refresher.dart';
import 'package:flutter_application_1/core/session/auth_session_store.dart';
import 'package:flutter_application_1/core/session/session_refresher.dart';
import 'package:flutter_application_1/core/storage/launch_flags/abstract_launch_flags_storage.dart';
import 'package:flutter_application_1/core/storage/launch_flags/launch_flags_storage.dart';
import 'package:flutter_application_1/core/storage/tokens/abstract_token_storage.dart';
import 'package:flutter_application_1/core/storage/tokens/token_storage.dart';
import 'package:flutter_application_1/repositories/authentication/abstract_authentication_repository.dart';
import 'package:flutter_application_1/repositories/authentication/authentication_repository.dart';
import 'package:flutter_application_1/repositories/session/abstract_session_repository.dart';
import 'package:flutter_application_1/repositories/session/session_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/core/network/network.dart';
import 'package:flutter_application_1/repositories/events/events.dart';

final sl = GetIt.instance;

void setupDependencies()
{
  //core
  sl.registerLazySingleton<AbstractAuthSessionStore>(() => AuthSessionStore());
  sl.registerLazySingleton<AbstractTokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<AbstractLaunchFlagsStorage>(() => LaunchFlagsStorage());
  
  //dio
  sl.registerLazySingleton<Dio>(() => createMainDio(), instanceName: 'mainDio');
  sl.registerLazySingleton<Dio>(() => createAuthDio(), instanceName: 'authDio');

  //repository
  sl.registerLazySingleton<AbstractEventsRepository>(() => EventsRepository(dio: sl<Dio>(instanceName: 'mainDio')));
  sl.registerLazySingleton<AbstractAuthenticationRepository>(() => AuthenticationRepository(dio: sl<Dio>(instanceName: 'authDio')));

  //session
  sl.registerLazySingleton<AbstractSessionRefresher>(() => SessionRefreshser(
    authenticationRepositry: sl<AbstractAuthenticationRepository>(),
    tokenStorage: sl<AbstractTokenStorage>(), sessionStorage: sl<AbstractAuthSessionStore>(),
  ));
  sl.registerLazySingleton<AbstractSessionRepository>(() => SessionRepository(
    authenticationRepository: sl<AbstractAuthenticationRepository>(),
    tokenStorage: sl<AbstractTokenStorage>(),
    launchFlagsStorage: sl<AbstractLaunchFlagsStorage>(),
    sessionStore: sl<AbstractAuthSessionStore>(),
  ));
}