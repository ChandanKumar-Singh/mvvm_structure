import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/app/modules/auth/controllers/auth_controller.dart';
import '/utils/my_logger.dart';

import '../app/modules/socialApp/providers/user_provider.dart';

class AuthService extends GetxService {
  final GetStorage authBox = GetStorage();
  final String isLoggedInKey = 'isLoggedIn';
  // static AuthService get to => Get.find()
  AuthService();
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  /// Mocks a login process
  bool _isLoggedIn = false;
  bool get isLoggedInValue => _isLoggedIn;

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  void checkLogin() async {
    String val = authBox.read(isLoggedInKey) ?? '';
    _isLoggedIn = val.isNotEmpty;
    if (_isLoggedIn) {
      Get.put(AuthController());
      Get.find<AuthController>().setCurrentUser(await SocialUserProvider
          .instance
          .getUserFromStorage(int.tryParse(val)));
    }
    logger.w('AuthService checkLogin isLoggedIn: $_isLoggedIn authbox: $val');
  }

  void login(String? id) {
    _isLoggedIn = true;
    authBox.write(isLoggedInKey, id);
  }

  void logout() {
    _isLoggedIn = false;
    authBox.remove(isLoggedInKey);
  }
}
