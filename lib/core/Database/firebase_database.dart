import '/core/Database/database.dart';

class FirebaseDatabase implements Database {
  FirebaseDatabase._internal();
  static final FirebaseDatabase _instance = FirebaseDatabase._internal();

  /// Returns the singleton instance
  static FirebaseDatabase get instance => _instance;

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
