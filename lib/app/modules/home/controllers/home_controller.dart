import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() =>
      Future.wait([Future(() => count.value++)]).then((value) => update());
}
