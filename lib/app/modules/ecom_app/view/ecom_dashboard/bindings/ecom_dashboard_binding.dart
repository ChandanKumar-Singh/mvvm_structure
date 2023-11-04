import 'package:get/get.dart';

import '../controllers/ecom_dashboard_controller.dart';

class EcomDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EcomDashboardController>(
      () => EcomDashboardController(),
    );
  }
}
