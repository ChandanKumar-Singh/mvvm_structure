import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/services/theme_services.dart';
import '/services/translation.dart';
import 'package:provider/provider.dart';

import 'app/modules/main_binding.dart';
import 'app/modules/page_not_found.dart';
import 'app/routes/app_pages.dart';
import 'services/device_preview_services.dart';

var initTheme = ThemeService.instance.initial;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DevicePreviewService.instance.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(app());
  });
}

Widget app() {
  return MyApp(initTheme: initTheme);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initTheme});
  final ThemeData initTheme;

  @override
  Widget build(BuildContext context) {
    primaryFocus?.unfocus();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicePreviewStore>(
          create: (_) => DevicePreviewStore(
              defaultDevice: Devices.ios.iPad,
              storage: DevicePreviewStorage.preferences()),
        ),
      ],
      child: ValueListenableBuilder(
          valueListenable: devicePreviewEnabled,
          builder: (context, value, child) {
            return ThemeProvider(
                initTheme: initTheme,
                builder: (_, theme) {
                  return DevicePreview(
                      enabled: value,
                      tools: const [
                        ...DevicePreview.defaultTools,
                      ],
                      builder: (context) {
                        return GetMaterialApp(
                          builder: DevicePreview.appBuilder,
                          initialBinding: MainBinding(),
                          initialRoute: AppPages.initial,
                          getPages: AppPages.routes,
                          locale: Get.deviceLocale,
                          fallbackLocale: const Locale('en', 'US'),
                          translations: TranslationService(),
                          unknownRoute: _unknownRoute(),
                          debugShowCheckedModeBanner: false,
                          theme: theme,
                          themeMode: ThemeMode.dark,
                        );
                      });
                });
          }),
    );
  }

  GetPage<dynamic> _unknownRoute() {
    return GetPage(
      name: Routes.pageNotFound,
      page: () => const PageNotFound(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
