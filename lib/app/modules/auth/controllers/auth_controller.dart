import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/models/auth/login_model.dart';
import '/app/modules/socialApp/models/user_model.dart';
import '/utils/my_logger.dart';

import '../../../models/root_models/root_user_model.dart';
import '../../../routes/app_pages.dart';
import '../../socialApp/providers/user_provider.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  Rx<AppUser>? _currentUser;
  Rx<AppUser>? get currentUser => _currentUser;

  late Rx<PageController> pageController;
  void setCurrentUser(AppUser? user) {
    _currentUser = user?.obs;
    logger.w('setCurrentUser: ${_currentUser?.value}');
    update();
  }

  Rx<AppUser>? selectedUser;
  void setSelectedUser(AppUser? user) {
    selectedUser = user?.obs;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController().obs;
    emailController = TextEditingController().obs;
    passwordController = TextEditingController().obs;
    pageController = PageController(initialPage: 0).obs;
    pageController.value.addListener(() {
      emailController.value.clear();
      passwordController.value.clear();
      nameController.value.clear();
      primaryFocus?.unfocus();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    pageController.value.dispose();
    super.dispose();
  }

  late Rx<TextEditingController> nameController;
  late Rx<TextEditingController> emailController;
  late Rx<TextEditingController> passwordController;
  RxBool loggingIn = false.obs;
  void setLoggingIn(bool value) {
    loggingIn.value = value;
    logger.w('setLoggingIn: ${loggingIn.value}');
    update();
  }

  Future<void> login({SocialLoginModel? loginModel, AppUser? appUser}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (loginModel != null) {
      final user = SocialAppUser(
        id: Random().nextInt(10000000),
        firstName: 'Mohamed',
        lastName: 'Ahmed',
        email: loginModel.email,
        phone: '01000000000',
        username: 'username_1',
        password: 'password_1',
        birthDate: '1999-01-01',
        image: 'https://via.placeholder.com/150',
        address: Address(
          address: 'El Haram',
          city: 'El Haram',
          state: 'El Haram',
        ),
        bank: Bank(
          cardNumber: '1234567890123456',
          cardType: 'Visa',
          currency: 'EGP',
          cardExpire: '01/01',
        ),
        userAgent: loginModel.socialLoginType.name,
      );

      SocialUserProvider.instance.storeNewUser(user).then((value) {
        _currentUser = null;
        setCurrentUser(user);
        return;
      }).catchError((e) {
        Get.snackbar('login loginModel Error', e.toString());
        return e;
      });
    } else if (appUser != null) {
      SocialUserProvider.instance
          .updateUser(appUser as SocialAppUser)
          .then((value) {
        _currentUser = null;
        setCurrentUser(appUser);
        return;
      }).catchError((e) {
        Get.snackbar('login AppUser Error', e.toString());
        return e;
      });
    }
  }

  Future<dynamic> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      setCurrentUser(null);
      Get.offAllNamed(Routes.auth);
      Get.snackbar('Success', 'Logout Success');
      return true;
    } catch (e) {
      return e;
    }
  }
}
