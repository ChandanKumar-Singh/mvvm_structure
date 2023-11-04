import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/sized_utils.dart';

import '../../../../generated/locales.g.dart';
import '../../../../services/auth_services.dart';
import '../../../../services/device_preview_services.dart';
import '../../../../services/theme_services.dart';
import '../../../../services/translation.dart';
import '../../../models/root_models/root_user_model.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../socialApp/models/user_model.dart';
import '../../socialApp/providers/user_provider.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  GlobalKey captureKey = GlobalKey();
  Image? image;

  @override
  Widget build(BuildContext context) {
    print('HomeDrawer: build $captureKey');
    return Drawer(
      child: RepaintBoundary(
        key: captureKey,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                image:
                    image != null ? DecorationImage(image: image!.image) : null,
              ),
              child: const Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const EnableDevicePreview(),
            CaptureScreenShot(
                captureKey: captureKey,
                onCapture: (img) => setState(() => image = img)),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.account),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () => showAccountsSheet(),
              title: const Text('Switch account'),
            ),

            ///change theme
            ThemeSwitcher(
                clipper: const ThemeSwitcherCircleClipper(),
                builder: (context) {
                  return ListTile(
                    onTap: () {
                      try {
                        ThemeService.instance.changeThemeMode(context);
                      } catch (e) {
                        log('error: $e');
                      }
                    },
                    title: const Text('Change theme'),
                    trailing: const Icon(Icons.brightness_6_rounded),
                  );
                }),

            ///change language
            ListTile(
              onTap: () {
                _changeLocaleSheet();
              },
              title: const Text('Change language'),
              trailing: const Icon(Icons.language),
            ),

            ///logout
            ListTile(
              onTap: () async {
                AuthService.instance.logout();
                Get.back();
                Get.offAllNamed(Routes.product);
              },
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }

  void _changeLocaleSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.grey,
        child: Wrap(
          children: [
            ...AppTranslation.translations.keys
                .map(
                  (e) => ListTile(
                    title: Text(e),
                    onTap: () {
                      TranslationService.changeLocale(e);
                      Get.back();
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

void showAccountsSheet() {
  Get.bottomSheet(
    // BottomSheet(
    //   onClosing: () {},
    //   elevation: 10,
    //   enableDrag: false,
    //   shadowColor: Colors.transparent,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) =>

    const ChangeAccountSheet(),
    backgroundColor: Colors.transparent,

    // ),
  );
}

class ChangeAccountSheet extends GetView<AuthController> {
  const ChangeAccountSheet({super.key});
  // final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final socialUserProvider = Get.put(SocialUserProvider.instance);
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (ctrl) {
          return Container(
            height: 200,
            margin: const EdgeInsetsDirectional.only(
              bottom: kBottomNavigationBarHeight,
              start: 10,
              end: 10,
            ),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                ...socialUserProvider.users
                    .map(
                      (e) => _UserTile(
                        user: e,
                        onChanged: (e) => _login(e, ctrl),
                        loggingIn: ctrl.loggingIn.value,
                        currentUser: ctrl.currentUser?.value,
                        selected:
                            (ctrl.selectedUser?.value as SocialAppUser?)?.id ==
                                e.id,
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        });
  }

  Future<void> _login(AppUser? appUser, AuthController controller) async {
    controller.setLoggingIn(true);
    controller.setSelectedUser(appUser);
    final thenTo = Get.parameters['then'];
    await controller
        .login(loginModel: null, appUser: appUser)
        .then((value) async {
      if (AuthController.to.currentUser != null) {
        Get.back();
        controller.setLoggingIn(false);
        AuthService.instance.login(
            (controller.currentUser?.value as SocialAppUser?)?.id.toString());
        await Future.delayed(const Duration(milliseconds: 500), () {
          Get.offNamed(Routes.home);
        }).then((value) {
          Get.snackbar(
            'Success',
            'Account switched to ${(appUser as SocialAppUser).firstName} ${(appUser).id}',
            backgroundColor: Colors.indigo,
          );
          if (thenTo != null) {
            Get.toNamed(thenTo);
          }
        });
      } else {
        controller.setLoggingIn(false);
      }
    }).catchError((e) {
      controller.setLoggingIn(false);
      Get.snackbar('Error', e.toString());
    });
  }
}

class _UserTile extends StatefulWidget {
  const _UserTile(
      {super.key,
      this.onChanged,
      required this.user,
      required this.loggingIn,
      required this.currentUser,
      this.selected = false});
  final Function(AppUser? user)? onChanged;
  final AppUser user;
  final bool loggingIn;
  final AppUser? currentUser;
  final bool selected;

  @override
  State<_UserTile> createState() => __UserTileState();
}

class __UserTileState extends State<_UserTile> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.selected;
    ;
    final user = widget.user as SocialAppUser;
    bool currentUser = (widget.currentUser as SocialAppUser?)?.id == user.id;
    return GestureDetector(
      onTap: () {
        widget.onChanged!(widget.user);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: selected
                ? getTheme(context).primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 20, backgroundImage: NetworkImage(user.image ?? '')),
              width10(),
              Text('${user.firstName} ${user.id}'),
              const Spacer(),
              widget.loggingIn && selected
                  ? const CupertinoActivityIndicator()
                  : currentUser
                      ? const Icon(Icons.check_rounded, color: Colors.white)
                      : const SizedBox(),
            ],
          )),
    );
  }
}
