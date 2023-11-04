import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import '/utils/color.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../../../../components/global_utils.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        initState: (state) {
          controller.progressValue.value = 20.0;
        },
        builder: (accCtrl) {
          return Scaffold(
            body: globalContainer(
              padding: EdgeInsets.symmetric(horizontal: paddingDefault),
              child: Column(
                children: [
                  ///appbar
                  _Appbar(context),

                  /// body
                  Expanded(
                    child: LayoutBuilder(builder: (context, bound) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ///profile image
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  accCtrl.progressValue.value += 20;
                                },
                                child: Builder(builder: (context) {
                                  double strokeWidth = 5;
                                  double size = bound.maxWidth * 0.25;
                                  return Stack(
                                    children: [
                                      SimpleCircularProgressBar(
                                        valueNotifier: accCtrl.progressValue,
                                        size: size,
                                        progressStrokeWidth: strokeWidth,
                                        backStrokeWidth: strokeWidth,
                                        backColor: Colors.white10,
                                        mergeMode: true,
                                        animationDuration: 5,
                                        progressColors: const [
                                          kPrimaryColor5,
                                          Colors.green,
                                        ],
                                      ),

                                      ///image
                                      Positioned(
                                        top: strokeWidth,
                                        left: strokeWidth,
                                        right: strokeWidth,
                                        bottom: strokeWidth,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white12,
                                          backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1622838177196-3b1b0b8b5b0f?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDQwfHh6eWJ4Z0JfZ0J8fGVufDB8fHx8&ixlib=rb-1.2.1&w=1000&q=80',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),

                          ///name
                          height20(),
                          Center(child: titleLargeText('John Doe')),

                          ///bids
                          height30(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    bodyLargeText('10'),
                                    width10(),
                                    bodyLargeText('Action wins'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  ///place bidbutton
                                  child: SizedBox(
                                    // width: bound.maxWidth * 0.5,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const AutoSizeText('Place Bid'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///user info
                          height30(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// bio
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      faIcon(FontAwesomeIcons.userTag),
                                      width5(),
                                      bodyMedText('Bio',
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                  height5(),
                                  bodyLargeText(
                                      'Lorem ipsum dolor sit amet, conse',
                                      fontWeight: FontWeight.w500),
                                ],
                              ),

                              ///location
                              height20(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      faIcon(FontAwesomeIcons.locationDot),
                                      width5(),
                                      bodyMedText('Location',
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                  height5(),
                                  bodyLargeText('Dhaka, Bangladesh',
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ),

                          ///bid history
                          height30(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  bodyMedText('Bid',
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar(this.context, {super.key});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///back button
          const AppBackButton(),

          titleLargeText('Profile'),
          const Spacer(),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.adaptive.share_rounded),
          ),
        ],
      ),
    );
  }
}
