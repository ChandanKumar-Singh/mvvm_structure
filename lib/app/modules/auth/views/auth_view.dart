import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/models/root_models/root_user_model.dart';
import '/components/global_utils.dart';
import '/utils/color.dart';
import '/utils/my_logger.dart';
import '/utils/text.dart';

import '../../../../services/auth_services.dart';
import '../../../../utils/sized_utils.dart';
import '../../../models/auth/login_model.dart';
import '../../../routes/app_pages.dart';
import '../../socialApp/models/user_model.dart';
import '../../socialApp/providers/user_provider.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            return Scaffold(
              body: Stack(
                children: [
                  globalContainer(),

                  ///top left clipper
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipShadowPath(
                      clipper: const MyClipper1(),
                      shadow:
                          const Shadow(blurRadius: 10, color: Colors.white24),
                      child: Container(
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kPrimaryColor5,
                              kPrimaryColor6,
                            ].reversed.toList(),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///bottom left circle
                  Positioned(
                    bottom: Get.height * 0.1,
                    left: Get.width * 0.1,
                    child: Container(
                      height: Get.height * 0.04,
                      width: Get.height * 0.04,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kPrimaryColor8,
                              kPrimaryColor9,
                            ].reversed.toList(),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ]),
                    ),
                  ),

                  ///bottom right circle
                  Positioned(
                    bottom: Get.height * 0.15,
                    right: -10,
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.height * 0.07,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              getTheme().primaryColor,
                              Colors.black,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ]),
                    ),
                  ),

                  ///top right circle
                  Positioned(
                    top: Get.height * 0.2,
                    right: Get.width * 0.1,
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.height * 0.07,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              kPrimaryColor10,
                              kPrimaryColor11,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ]),
                    ),
                  ),

                  ///pageview
                  Positioned(
                    top: paddingDefault * 2,
                    bottom: paddingDefault * 2,
                    left: 0,
                    right: 0,
                    child: PageView(
                      controller: authCtrl.pageController.value,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _SignInPageView(),
                        _SignUpPageView(),
                      ],
                    ),
                  ),

                  ///loading indicator
                  if (authCtrl.loggingIn.value)
                    Positioned(
                      bottom: paddingDefault * 5,
                      left: paddingDefault * 2,
                      right: paddingDefault * 2,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CupertinoActivityIndicator()],
                      ),
                    ),

                  ///footer
                  Positioned(
                    bottom: paddingDefault * 2,
                    left: paddingDefault * 2,
                    right: paddingDefault * 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.copyright,
                            color: Colors.grey, size: 15),
                        width5(),
                        bodyMedText(DateTime.now().year.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _SignInPageView extends StatelessWidget {
  _SignInPageView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authCtrl) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: spaceDefault * 2),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        displayLarge('Sign In', fontSize: 32),
                        height5(),
                        bodyLargeText('Sign in to continue'),
                        height30(),
                      ],
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    controller: authCtrl.emailController.value,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: false,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  height10(),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    controller: authCtrl.passwordController.value,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      isDense: false,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (newValue) {
                      _login(
                          SocialLoginModel(
                              email: authCtrl.emailController.value.text,
                              password: authCtrl.passwordController.value.text),
                          null,
                          authCtrl);
                    },
                  ),
                  height20(),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: authCtrl.loggingIn.value
                              ? null
                              : () {
                                  _login(
                                      SocialLoginModel(
                                          email: authCtrl
                                              .emailController.value.text,
                                          password: authCtrl
                                              .passwordController.value.text),
                                      null,
                                      authCtrl);
                                },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Sign In'),
                              // if (!authCtrl.loggingIn.value)
                              //   Row(
                              //     mainAxisSize: MainAxisSize.min,
                              //     children: [
                              //       width10(),
                              //       const CupertinoActivityIndicator(),
                              //     ],
                              //   )
                            ],
                          )),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: bodyLargeText('Forgot Password?'),
                      ),
                    ],
                  ),
                  height30(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: getTheme().textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Create one',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authCtrl.pageController.value.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn);
                            },
                          style: getTheme()
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: kPrimaryColor5),
                        ),
                      ],
                    ),
                  ),
                  _SaveduserdropDown(
                      onChanged: (AppUser? user) =>
                          _login(null, user, authCtrl)),
                ],
              ),
            ),
          );
        });
  }

  _login(SocialLoginModel? socialLoginModel, AppUser? appUser,
      AuthController controller) async {
    try {
      bool proceed =
          appUser != null ? true : (_formKey.currentState?.validate() ?? false);
      if (proceed) {
        controller.setLoggingIn(true);
        primaryFocus?.unfocus();
        // await Future.delayed(const Duration(milliseconds: 5000));
        // controller.setLoggingIn(false);
        // return;
        final thenTo = Get.parameters['then'];
        controller
            .login(loginModel: socialLoginModel, appUser: appUser)
            .then((value) {
          if (controller.currentUser != null) {
            controller.setLoggingIn(false);
            AuthService.instance.login(
                (controller.currentUser?.value as SocialAppUser?)
                    ?.id
                    .toString());
            Get.offAllNamed(Routes.home);
            // }).then((value) {
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.snackbar('Success',
                  'Logged in successfully\nWelcome back ${(appUser as SocialAppUser?)?.firstName ?? ''}',
                  backgroundColor: Colors.green);
              if (thenTo != null) {
                Get.toNamed(thenTo);
              }
            });
          } else {
            controller.setLoggingIn(false);
          }
        });
      }
    } catch (e) {
      logger.e('login error', tag: 'AuthView', error: e);
    }
  }
}

class _SignUpPageView extends StatelessWidget {
  _SignUpPageView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authCtrl) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: spaceDefault * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      displayLarge('Sign Up', fontSize: 32),
                      height5(),
                      bodyLargeText('Sign up to continue'),
                      height30(),
                    ],
                  ),
                ),

                ///name
                TextFormField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  controller: authCtrl.nameController.value,
                  decoration: InputDecoration(
                    isDense: false,
                    hintText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                height10(),

                ///email
                TextFormField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  controller: authCtrl.emailController.value,
                  decoration: InputDecoration(
                    isDense: false,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                height10(),
                TextFormField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  controller: authCtrl.passwordController.value,
                  decoration: InputDecoration(
                    isDense: false,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                height20(),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Sign Up')),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: bodyLargeText('Forgot Password?'),
                    ),
                  ],
                ),
                height30(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: getTheme().textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            authCtrl.pageController.value.animateToPage(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          },
                        style: getTheme()
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: kPrimaryColor5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MyClipper1 extends CustomClipper<Path> {
  const MyClipper1();
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width * (size.width > size.height ? 0.8 : 1);

    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(w * 0.2, size.height, w * 0.4, size.height * 0.8);
    path.quadraticBezierTo(
        w * 0.6, size.height * 0.6, w * 0.55, size.height * 0.4);
    path.quadraticBezierTo(w * 0.5, size.height * 0.2, w * 0.3, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(MyClipper1 oldClipper) => true;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow? shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    super.key,
    this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow? shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow?.toPaint() ?? Paint();
    var clipPath = clipper.getClip(size);
    if (shadow != null) clipPath = clipPath.shift(shadow!.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/*
  ///[old login ui ] testin purpose
  ListView _listview() {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Ender email and password to login',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: controller.emailController.value,
                  decoration: const InputDecoration(
                    isDense: false,
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.passwordController.value,
                  decoration: const InputDecoration(
                    isDense: false,
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        _SaveduserdropDown(onChanged: (AppUser? user) => _login(null, user)),

        //login button
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => _login(
              SocialLoginModel(
                  email: controller.emailController.value.text,
                  password: controller.passwordController.value.text),
              null),
          child: const Text('Login'),
        ),
      ],
    );
  }
*/

class _SaveduserdropDown extends StatefulWidget {
  const _SaveduserdropDown({Key? key, this.onChanged}) : super(key: key);
  final Function(AppUser? user)? onChanged;

  @override
  State<_SaveduserdropDown> createState() => _SaveduserdropDownState();
}

class _SaveduserdropDownState extends State<_SaveduserdropDown> {
  AppUser? selectedUser;
  @override
  Widget build(BuildContext context) {
    final socialUserProvider = Get.put(SocialUserProvider.instance);
    final savedUsers = socialUserProvider.users;
    return GetBuilder<AuthController>(builder: (ctrl) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Choose existing',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400]),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DropdownButton<AppUser?>(
                          borderRadius: BorderRadius.circular(10),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                          underline: Container(
                              height: 1.0,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.red, width: 0.0)))),
                          isExpanded: true,
                          hint: const Text('Select user'),
                          disabledHint: const Text('No users found'),
                          dropdownColor: Colors.grey[200],
                          value: selectedUser,
                          onChanged: (AppUser? value) {
                            setState(() {
                              selectedUser = value;
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return savedUsers
                                .map(
                                  (e) => Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage:
                                            NetworkImage(e.image ?? ''),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${e.firstName ?? ''}dfdf _${e.id}',
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                )
                                .toList();
                          },
                          items: savedUsers
                              .map(
                                (e) => DropdownMenuItem<AppUser?>(
                                  value: e,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage:
                                            NetworkImage(e.image ?? ''),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${e.firstName ?? ''}dfdf _${e.id}',
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: ctrl.loggingIn.value
                        ? const CupertinoActivityIndicator()
                        : IconButton(
                            onPressed: selectedUser == null
                                ? null
                                : () {
                                    widget.onChanged!(selectedUser);
                                  },
                            icon: const Icon(Icons.arrow_forward_rounded),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
