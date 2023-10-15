import '/core/Database/database.dart';

class HiveDatabase implements Database {
  HiveDatabase._internal();
  static final HiveDatabase _instance = HiveDatabase._internal();

  /// Returns the singleton instance
  static HiveDatabase get instance => _instance;

  bool _isInitialized = false;
  @override
  bool isInitialized = false;

  @override
  Future<bool> init() {
    _isInitialized = true;
    isInitialized = _isInitialized;
    return Future.value(true);
  }
}
