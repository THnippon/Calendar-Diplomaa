abstract interface class AbstractLaunchFlagsStorage {
  Future<bool> getHasSeenWelcome();
  Future<void> setHasSeenWelcome(bool value);
}