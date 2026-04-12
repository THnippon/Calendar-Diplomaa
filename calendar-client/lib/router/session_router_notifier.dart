import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/session/cubit/session_cubit.dart';
import 'package:flutter_application_1/features/session/cubit/session_state.dart';

class SessionRouterNotifier extends ChangeNotifier {
  SessionRouterNotifier ({
    required SessionCubit sessionCubit,
  }) : _sessionCubit = sessionCubit {
    _subscription = _sessionCubit.stream.listen((SessionState _) {
      notifyListeners();
    });
  }

  final SessionCubit _sessionCubit;
  late final StreamSubscription<SessionState> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}