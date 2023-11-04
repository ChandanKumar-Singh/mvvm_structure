import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/modules/auth/controllers/auth_controller.dart';
import '/app/modules/home/views/home_drawer.dart';
import '../controllers/home_controller.dart';
import 'bottomNav/hom_bottom_nav_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: GetBuilder<HomeController>(
          // init: HomeController(),
          builder: (homeCtrl) {
        return GetBuilder<AuthController>(
            init: AuthController(),
            builder: (authCtrl) {
              return ProvidedStylesExample(
                menuScreenContext: context,
                drawer: HomeDrawer(),
              );
            });
      }),
    );
  }
}
