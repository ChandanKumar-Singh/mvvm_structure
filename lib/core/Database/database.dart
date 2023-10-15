abstract class Database {
  bool get isInitialized => false;
  Future<bool> init();
}
