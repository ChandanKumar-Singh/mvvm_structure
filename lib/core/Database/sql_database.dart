import '/core/Database/database.dart';

class SQLDatabase implements Database {
  SQLDatabase._internal();
  static final SQLDatabase _instance = SQLDatabase._internal();

  /// Returns the singleton instance
  static SQLDatabase get instance => _instance;

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
