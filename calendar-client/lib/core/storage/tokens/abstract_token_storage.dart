abstract interface class AbstractTokenStorage{
  Future<String?> readRefreshToken();
  Future<void> writeRefreshToket(String token);
  Future<void> deleteRefreshToken();
}