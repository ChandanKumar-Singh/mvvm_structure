import 'package:mvvm_structure/core/Database/database.dart';

class RestApiDatabase implements Database {
  RestApiDatabase._internal();
  static final RestApiDatabase _instance = RestApiDatabase._internal();

  /// Returns the singleton instance
  static RestApiDatabase get instance => _instance;

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
