import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/di/dependencies.dart';
import 'package:flutter_application_1/core/session/abstract_auth_session_store.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        sessionStore: sl<AbstractAuthSessionStore>(),
        )..loadProfile(),
        child: const ProfileScreen(),
      );
  }
}