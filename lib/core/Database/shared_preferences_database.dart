import '/core/Database/database.dart';

class SPDatabase implements Database {
  SPDatabase._internal();
  static final SPDatabase _instance = SPDatabase._internal();

  /// Returns the singleton instance
  static SPDatabase get instance => _instance;

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
