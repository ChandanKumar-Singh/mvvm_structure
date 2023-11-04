import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  //TODO: Implement AccountController

  final count = 0.obs;
  late ValueNotifier<double> progressValue;

  @override
  void onInit() {
    super.onInit();
    progressValue = ValueNotifier(0.0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
