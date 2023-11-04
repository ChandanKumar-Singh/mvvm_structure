import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import "/app/modules/auth/controllers/auth_controller.dart";
import "/app/modules/home/views/bottomNav/dashboard.dart";
import "/app/modules/home/views/home_drawer.dart";
import "/app/modules/socialApp/models/user_model.dart";
import "/app/routes/app_pages.dart";
import "/utils/color.dart";
import "/utils/sized_utils.dart";
import "/utils/text.dart";

BuildContext? testContext;

// ----------------------------------------- Provided Style ----------------------------------------- //
class ProvidedStylesExample extends StatefulWidget {
  const ProvidedStylesExample({
    final Key? key,
    required this.menuScreenContext,
    required this.drawer,
    // required this.body,
    // required this.floatingActionButton,
  }) : super(key: key);
  final BuildContext menuScreenContext;
  final Widget drawer;
  // final Widget body;
  // finsal Widget floatingActionButton;

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => [
        const HomeDashboard(),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
      ];

  //suggest five nav bar names and icons for and auction app , features: home, live bids, profile, settings, notification

  List<PersistentBottomNavBarItem> _navBarsItems(AuthController authCtrl) {
    var name = (authCtrl.currentUser?.value as SocialAppUser?)?.firstName ?? '';
    var id = (authCtrl.currentUser?.value as SocialAppUser?)?.id;
    String tabName = name.isNotEmpty ? name : 'Login';
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.purple),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bakery_dining_rounded),
        title: "Live Bids",
        activeColorPrimary: kPrimaryColor5,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history_edu_rounded),
        title: "History",
        activeColorPrimary: kPrimaryColor10,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat_outlined),
        title: "Chats",
        activeColorPrimary: kPrimaryColor9,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: name.isNotEmpty
            ? Stack(
                children: [
                  CircleAvatar(
                    // radius: 10,
                    // height: 30,
                    // width: 30,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   image: DecorationImage(
                    //     image:
                    backgroundImage: NetworkImage(
                        ((authCtrl.currentUser?.value as SocialAppUser?)
                                        ?.image ??
                                    '')
                                .isEmpty
                            ? 'https://picsum.photos/250?image=9'
                            : 'https://picsum.photos/250?image=10'),
                    // fit: BoxFit.cover,
                    // ),
                    // ),
                  ),

                  /// if id is not empty
                  if (id != null)
                    Positioned(
                      right: 0,
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child: capText(
                                id
                                    .toString()
                                    .trim()
                                    .substring(tabName.length - 1),
                                color: Colors.white),
                          )),
                    )
                ],
              )
            : const Icon(Icons.login),
        activeColorSecondary: Colors.transparent,
        inactiveColorSecondary: Colors.transparent,
        title: name.isNotEmpty ? null : 'Login',
        // contentPadding: 10,
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        onPressed: (final context) {
          // Get.toNamed(Routes.pageNotFound);
          showAccountsSheet();
        },
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: Routes.product,
        //   routes: {
        //     Routes.product: (final context) => const ProductView(),
        //     //     // "/second": (final context) => const MainScreen3(),
        //   },
        // ),
      ),
    ];
  }

  @override
  Widget build(final BuildContext context) => GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authCtrl) {
        return Scaffold(
          drawer: widget.drawer,
          body: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(authCtrl),
            resizeToAvoidBottomInset: true,
            bottomScreenMargin: 0,
            margin: const EdgeInsets.all(0.0),

            confineInSafeArea: true,
            // neumorphicProperties: const NeumorphicProperties(
            //   borderRadius: 10,
            //   bevel: 10,
            // ),
            navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0.0
                : kBottomNavigationBarHeight,
            // handleAndroidBackButtonPress: false,
            // onWillPop: _onWillPop,
            selectedTabScreenContext: (final context) => testContext = context,
            backgroundColor: getTheme(context).primaryColor,
            hideNavigationBar: _hideNavBar,
            decoration: NavBarDecoration(
                colorBehindNavBar: Colors.indigo,
                gradient: LinearGradient(
                  colors: [
                    getTheme(context).primaryColor,
                    getTheme(context).primaryColorDark,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 15.0),
                  // BoxShadow(color: Colors.white30, blurRadius: 10.0),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 400), curve: Curves.ease),
            screenTransitionAnimation:
                const ScreenTransitionAnimation(animateTabTransition: true),
            navBarStyle: NavBarStyle
                .style14, // Choose the nav bar style with this property
          ),
        );
      });

  Future<bool> _onWillPop(final context) async {
    await showDialog(
      context: Get.context!,
      useSafeArea: true,
      builder: (final context) => Container(
        height: 50,
        width: 50,
        color: Colors.white,
        child: ElevatedButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    return false;
  }
}

//main screen
class MainScreen extends StatelessWidget {
  const MainScreen({
    final Key? key,
    required this.hideStatus,
    required this.onScreenHideButtonPressed,
    required this.menuScreenContext,
  }) : super(key: key);
  final bool hideStatus;
  final Function onScreenHideButtonPressed;
  final BuildContext menuScreenContext;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Main Screen"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed("/second");
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Main Screen"),
              ElevatedButton(
                child: const Text("Go to the next screen"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/second");
                },
              ),
              ElevatedButton(
                child: const Text("Open Drawer"),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              ElevatedButton(
                child: const Text("Hide navigation bar"),
                onPressed: () {
                  onScreenHideButtonPressed();
                },
              ),
            ],
          ),
        ),
      );
}



// ----------------------------------------- Custom Style ----------------------------------------- //

// class CustomNavBarWidget extends StatelessWidget {
//   const CustomNavBarWidget(
//     this.items, {
//     final Key key,
//     this.selectedIndex,
//     this.onItemSelected,
//   }) : super(key: key);
//   final int selectedIndex;
//   final List<PersistentBottomNavBarItem> items;
//   final ValueChanged<int> onItemSelected;

//   Widget _buildItem(
//           final PersistentBottomNavBarItem item, final bool isSelected) =>
//       Container(
//         alignment: Alignment.center,
//         height: kBottomNavigationBarHeight,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Flexible(
//               child: IconTheme(
//                 data: IconThemeData(
//                     size: 26,
//                     color: isSelected
//                         ? (item.activeColorSecondary ?? item.activeColorPrimary)
//                         : item.inactiveColorPrimary ?? item.activeColorPrimary),
//                 child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 5),
//               child: Material(
//                 type: MaterialType.transparency,
//                 child: FittedBox(
//                     child: Text(
//                   item.title,
//                   style: TextStyle(
//                       color: isSelected
//                           ? (item.activeColorSecondary ??
//                               item.activeColorPrimary)
//                           : item.inactiveColorPrimary,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12),
//                 )),
//               ),
//             )
//           ],
//         ),
//       );

//   @override
//   Widget build(final BuildContext context) => Container(
//         color: Colors.white,
//         child: SizedBox(
//           width: double.infinity,
//           height: kBottomNavigationBarHeight,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: items.map((final item) {
//               final int index = items.indexOf(item);
//               return Flexible(
//                 child: GestureDetector(
//                   onTap: () {
//                     onItemSelected(index);
//                   },
//                   child: _buildItem(item, selectedIndex == index),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
// }
