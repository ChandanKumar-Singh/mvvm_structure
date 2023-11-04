import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/text.dart';

import '../../../../components/global_utils.dart';
import '../../../routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.intro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: globalPageGradient(),
          ),
          child: Center(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Image.asset(
              'assets/images/logo-no-background.png',
              // height: 100,
              // width: 100,
            ),
          ))),
    );
  }
}
