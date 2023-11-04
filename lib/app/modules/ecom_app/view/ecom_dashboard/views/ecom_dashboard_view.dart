import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ecom_dashboard_controller.dart';

class EcomDashboardView extends GetView<EcomDashboardController> {
  const EcomDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcomDashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EcomDashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
