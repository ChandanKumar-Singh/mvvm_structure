import "dart:developer";
import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "/utils/color.dart";
import "/utils/sized_utils.dart";

import "../../../../../components/global_utils.dart";
import "../../../../../generated/locales.g.dart";
import "../../../../../utils/page_animatiom.dart";
import "../../../../../utils/text.dart";
import "../../../../routes/app_pages.dart";
import "../../../auth/controllers/auth_controller.dart";
import "../../../page_not_found.dart";
import "../../../socialApp/models/user_model.dart";
import "../../controllers/home_controller.dart";
import "../home_banner_slider.dart";
import "../home_hot_bids_staggerd.dart";

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        // init: HomeController(),
        builder: (homeCtrl) {
      return GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            return Scaffold(
              body: _body(context, authCtrl, homeCtrl),
              floatingActionButton: _floatingTab(homeCtrl),
            );
          });
    });
  }

  Widget _floatingTab(HomeController ctr) {
    return FloatingActionButton(
      onPressed: () => ctr.increment(),
      child: const Icon(Icons.store_mall_directory_rounded),
    );
  }

  Container _body(
      BuildContext context, AuthController authCtrl, HomeController ctr) {
    return globalContainer(
      child: SafeArea(
        child: Column(
          children: [
            ///app logo and notification icon
            _appbar(context, authCtrl),

            ///body
            Expanded(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///search bar
                  height10(),
                  const _buildSearchBar(),

                  ///banner slider
                  height20(),
                  HomeBannerSlider(),

                  ///hot bids
                  height20(),
                  const MasonryPage(),

                  const Center(
                    child: Text(
                      'HomeView is working',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      LocaleKeys.msg
                          .trParams({'hello': 'John', 'world': 'Flutter'}),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      LocaleKeys.clicked_other
                          .trParams({'count': ctr.count.string}),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    LocaleKeys.clickMe.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  //page not found
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.pageNotFound),
                    child: const Text('Page not found'),
                  ),
                  OpenContainer<bool>(
                    transitionType: ContainerTransitionType.fade,
                    openBuilder: (BuildContext context, VoidCallback _) {
                      return const PageNotFound();
                    },
                    onClosed: (bool? data) {
                      log('data: $data');
                    },
                    tappable: false,
                    replaceRoute: true,
                    transitionDuration: const Duration(milliseconds: 1000),
                    closedBuilder:
                        (BuildContext _, VoidCallback openContainer) {
                      return ElevatedButton(
                          onPressed: openContainer,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/250?image=9'),
                          ));
                    },
                  ),

                  //
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context, AuthController authCtrl) {
    SocialAppUser? user = authCtrl.currentUser?.value as SocialAppUser?;
    log('_Appbar currentUser: ${authCtrl.currentUser}');
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          width10(paddingDefault / 2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: kToolbarHeight - 10),
            child: Image.asset(
              'assets/images/logo-no-background.png',
              // height: 100,
              // width: 100,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        width10(paddingDefault / 2),
      ],
    );
  }
}

class _buildSearchBar extends StatelessWidget {
  const _buildSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        blendMode: BlendMode.srcOver,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: paddingDefault),
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors:
                            [kPrimaryColor6, lightAccent].reversed.toList()),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      icon: const Icon(CupertinoIcons.search,
                          color: Colors.white38),
                      onPressed: () {})),
              width10(),
              Column(
                children: [
                  bodyLargeText('Search', color: Colors.white60),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
