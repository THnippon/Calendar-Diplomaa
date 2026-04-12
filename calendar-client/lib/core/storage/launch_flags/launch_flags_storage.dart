import 'package:flutter_application_1/core/storage/launch_flags/abstract_launch_flags_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchFlagsStorage implements AbstractLaunchFlagsStorage {
  LaunchFlagsStorage ({
    SharedPreferencesAsync? preferences,
  }) : _preferences = preferences ?? SharedPreferencesAsync();



  static const String _hasSeenWelcomeKey = 'app.has_seen_welcome';
  final SharedPreferencesAsync _preferences;

  @override
  Future<void> setHasSeenWelcome(bool value) {
    return _preferences.setBool(_hasSeenWelcomeKey, value);
  }

  @override
  Future<bool> getHasSeenWelcome() async {
    final value = await _preferences.getBool(_hasSeenWelcomeKey);
    return value ?? false;
  }
}