import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/components/global_utils.dart';
import '/utils/text.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/random_image_tile.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../utils/picture_utils.dart';
import '../../../../utils/sized_utils.dart';
import '../controllers/auction_detail_controller.dart';
import 'dart:math';
import 'package:collection/collection.dart';

import 'aution_details_bid_popup_view.dart';

class AuctionDetailView extends GetView<AuctionDetailController> {
  const AuctionDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionDetailController>(
        init: AuctionDetailController(),
        builder: (acutionDetailController) {
          return Scaffold(
            body: globalContainer(
              padding: EdgeInsets.symmetric(horizontal: paddingDefault),
              child: Column(
                children: [
                  /// addptive icon for back button
                  _AppBar(acutionDetailController),

                  /// body
                  _Body(acutionDetailController)
                ],
              ),
            ),
            bottomNavigationBar: const _BottomNavigationBar(),
          );
        });
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight) +
          (defaultTargetPlatform == TargetPlatform.iOS ? 20 : 0),
      padding: EdgeInsets.symmetric(horizontal: paddingDefault),
      decoration: BoxDecoration(
        color: getTheme().primaryColor,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.fromBorderSide(color: Colors.white70, width: 2),
      ),
      child: Row(
        children: [
          ///bid button
          SizedBox(
            width: Get.width * 0.4,
            child: AspectRatio(
              aspectRatio: 4,
              child: TextButton.icon(
                onPressed: () {
                  // Get.toNamed(Routes.autionDetail);
                },
                icon: assetSvg(MySvg.diamond, height: 15, width: 15),
                label: AutoSizeText(
                  'Bids (23)',
                  minFontSize: 10,
                  // presetFontSizes: [20, 18, 16, 14, 12, 10],
                  style: getTheme().textTheme.displayLarge,
                ),
              ),
            ),
          ),

          ///buy now button
          SizedBox(
            width: Get.width * 0.4,
            child: AspectRatio(
              aspectRatio: 4,
              child: TextButton.icon(
                onPressed: () {
                  // Get.toNamed(Routes.autionDetail);
                },
                icon: assetSvg(MySvg.diamond, height: 15, width: 15),
                label: AutoSizeText(
                  'Favorites (5)',
                  minFontSize: 10,
                  // presetFontSizes: [20, 18, 16, 14, 12, 10],
                  style: getTheme().textTheme.displayLarge,
                ),
              ),
            ),
          ),

          /// all bids icon button
          IconButton(
            onPressed: () {
              // Get.toNamed(Routes.autionDetail);
            },
            icon: Icon(Icons.adaptive.more),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(
    this.acutionDetailController, {
    super.key,
  });
  final AuctionDetailController acutionDetailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: appBarTopMargin(),
      child: Row(
        children: [
          const AppBackButton(onTap: null),
          const Spacer(),

          ///share button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.adaptive.share),
          ),

          ///favorite button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(
    this.acutionDetailController, {
    super.key,
  });
  final AuctionDetailController acutionDetailController;

  @override
  Widget build(BuildContext context) {
    var htmlContent = r'''
<div class="css-5xpyxn" id="LotDetails"><div class="css-1u4ivnx"><p class="label-module_label18Medium__LZmdm css-131vre8">Lot Details</p><div class="css-r9bic9"></div></div><div class="css-jcm9fl"></div><p class="label-module_label18Medium__LZmdm css-r6e2mi">Description</p><div class="css-1aw519d"><p>Patek Philippe</p><p><br></p><p>Nautilus, Reference 5990/1A-001</p><p>A stainless steel dual time zone flyback chronograph wristwatch with date and dual day/night indication</p><p>Circa 2020</p><p><br></p><p><strong>Dial:&nbsp;</strong>black</p><p><strong>Calibre:</strong>&nbsp;cal. 28-520 automatic, 34 jewels&nbsp;</p><p><strong>Case:</strong>&nbsp;stainless steel, screw-down sapphire crystal display case back&nbsp;</p><p><strong>Closure:&nbsp;</strong>stainless steel Patek Philippe bracelet and double-folding clasp&nbsp;</p><p><strong>Size:&nbsp;</strong>44 mm diameter (9-3 o'clock), bracelet circumference approximately 200 mm (including additional link)</p><p><strong>Signed:&nbsp;</strong>case, dial and movement&nbsp;</p><p><strong>Box:&nbsp;</strong>yes</p><p><strong>Papers:&nbsp;</strong>no</p><p><strong>Accessories:&nbsp;</strong>Patek Philippe copy of Certificate of Origin, instruction manual, setting pin, leather bifold, travel case and presentation case with outer packaging&nbsp;</p></div><div class="css-1yuhvjn"><button aria-expanded="false" class="css-o5hob9"><p class="label-module_label18Medium__LZmdm css-r6e2mi">Condition report</p><div><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-12efcmn"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-dm37tw"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg></div></button><div aria-hidden="true" class="rah-static rah-static--height-zero" style="height: 0px; overflow: hidden;"><div style="display: none;"><div class="css-1fes8lf">Please log in</div></div></div></div><div class="css-1yuhvjn"><button aria-expanded="true" class="css-o5hob9"><p class="label-module_label18Medium__LZmdm css-r6e2mi">Catalogue note</p><div><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-12efcmn"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-qih3n9"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg></div></button><div aria-hidden="false" class="rah-static rah-static--height-auto" style="height: auto; overflow: visible;"><div><div class="css-1fes8lf"><p>The Patek Philippe reference 5990 made its debut in 2014. The story actually starts almost a decade earlier though. In 2006, Patek Philippe celebrated the 30th anniversary of the Nautilus collection. To mark the occasion, the original design by&nbsp;Gerald Genta&nbsp;from 1976, was updated ever so slightly.</p><p>This model is only available in steel and only with a gradient grey dial. It features the familiar horizontally embossed Nautilus pattern. As well as the central dual time display, the date is shown on a sub-dial at 12 o’clock. This is linked to the local time display. The ten gold applied hour markers and local hour and minute hand have a luminescent coating. The day/night indicators are positioned below the center axis. The one for local time is at 9 o’clock. The one for home time is at three o’clock. These show white for day and blue for night.</p></div></div></div></div><div class="css-1yuhvjn"><button aria-expanded="false" class="css-o5hob9"><p class="label-module_label18Medium__LZmdm css-r6e2mi">Additional Notices &amp; Disclaimers</p><div><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-12efcmn"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg><svg width="24" height="24" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="css-dm37tw"><path d="M19.25 12.75H4.75a.75.75 0 0 1 0-1.5h14.5a.75.75 0 0 1 0 1.5Z"></path></svg></div></button><div aria-hidden="true" class="rah-static rah-static--height-zero" style="height: 0px; overflow: hidden;"><div style="display: none;"><div class="css-1fes8lf"><p><em>Please note that Condition 12 of the Conditions of Business for Buyers (Online Only) is not applicable to this lot.</em></p></div></div></div></div></div>
''';
    var amount = formatMoney(1000000);
    return Expanded(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        /// image slider
        _AutionImagesBannerSlider(),

        /// title
        height20(),
        titleLargeText('Rolex Submariner',
            color: getTheme().textTheme.displayLarge?.color),

        ///timer container
        height20(),
        _BuildTimerWidget(acutionDetailController: acutionDetailController),

        /// current bid
        height20(),
        Row(
          children: [
            titleMedText('Current bid'),
            const Spacer(),
            bodyLargeText(amount.output.symbolOnLeft,
                style: getTheme()
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w900)),
            width5(),
            assetSvg(MySvg.diamond, height: 12, width: 12),
          ],
        ),

        /// seller detail
        height20(),
        Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/howto/img_avatar.png'),
            ),
            width10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                capText('Seller'),
                bodyLargeText('John Doe',
                    fontWeight: FontWeight.bold,
                    color: getTheme().textTheme.displayLarge?.color),
              ],
            ),
          ],
        ),

        /// description
        height20(),
        Column(children: [
          Row(
            children: [
              bodyMedText('Description', fontWeight: FontWeight.bold),
              width30(),
              bodyMedText(
                'Bid history ➡️',
                decoration: TextDecoration.underline,
              ),
            ],
          ),
          height10(),
          //lorem ipsum 100 words
          Builder(builder: (context) {
            return HTML.toRichText(
              context,
              htmlContent,
              defaultTextStyle: TextStyle(
                color: getTheme().textTheme.titleLarge?.color,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              linksCallback: (link) async {
                Uri uri = (link is String) ? Uri.parse(link) : link;
                if (await canLaunchUrl(uri)) {
                  launchUrl(uri);
                } else {
                  Get.snackbar('Error', 'Cannot launch url');
                }
              },
            );
          }),
        ]),
      ],
    ));
  }
}

class _BuildTimerWidget extends StatelessWidget {
  const _BuildTimerWidget({
    super.key,
    required this.acutionDetailController,
  });
  final AuctionDetailController acutionDetailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: paddingDefault, vertical: paddingDefault),
      decoration: BoxDecoration(
        color: getTheme().primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white70, width: 2),
      ),
      child: LayoutBuilder(builder: (context, bound) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bodyLargeText('Auction ends in'),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '00',
                    style: getTheme()
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)),
                    children: const <TextSpan>[
                      TextSpan(text: 'h:'),
                    ],
                  ),
                ),
                width10(),
                RichText(
                  text: TextSpan(
                    text: '00',
                    style: getTheme()
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)),
                    children: const <TextSpan>[
                      TextSpan(text: 'm:'),
                    ],
                  ),
                ),
                width10(),
                RichText(
                  text: TextSpan(
                    text: '00',
                    style: getTheme()
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)),
                    children: const <TextSpan>[
                      TextSpan(text: 's'),
                    ],
                  ),
                ),
                const Spacer(),

                ///place a bid button
                SizedBox(
                  width: bound.maxWidth * 0.4,
                  child: AspectRatio(
                    aspectRatio: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(Routes.autionDetail);
                        Get.generalDialog(
                          barrierColor: Colors.white.withOpacity(0.05),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const AutionDetailsBidPopupView();
                          },
                        );
                      },
                      child: AutoSizeText(
                        'Place a bid',
                        minFontSize: 10,
                        // presetFontSizes: [20, 18, 16, 14, 12, 10],
                        style: getTheme().textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),

                /*
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingDefault,
                          vertical: paddingDefault),
                      decoration: BoxDecoration(
                          color:
                              getTheme().scaffoldBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text(
                            '00',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height5(),
                          const Text(
                            'Days'
                          ),
                        ],
                      ),
                    ),
                    width10(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingDefault,
                          vertical: paddingDefault),
                      decoration: BoxDecoration(
                          color:
                              getTheme().scaffoldBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text(
                            '00',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height5(),
                          const Text(
                            'Hours'
                          ),
                        ],
                      ),
                    ),
                    width10(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingDefault,
                          vertical: paddingDefault),
                      decoration: BoxDecoration(
                          color:
                              getTheme().scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10)
                          // border: Border.all(color: Colors.white),
                          ),
                      child: Column(
                        children: [
                          const Text(
                            '00',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height5(),
                          const Text(
                            'Minutes'
                          ),
                        ],
                      ),
                    ),
                    width10(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingDefault,
                          vertical: paddingDefault),
                      decoration: BoxDecoration(
                          color:
                              getTheme().scaffoldBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Text(
                            '00',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          height5(),
                          const Text(
                            'Seconds'
                          ),
                        ],
                      ),
                    ),
                 */
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _AutionImagesBannerSlider extends StatefulWidget {
  _AutionImagesBannerSlider({super.key});

  @override
  State<_AutionImagesBannerSlider> createState() =>
      _AutionImagesBannerSliderState();
}

class _AutionImagesBannerSliderState extends State<_AutionImagesBannerSlider> {
  late CarouselController buttonCarouselController;
  int _current = 0;

  // late PageController _pageController;

  List<Widget> child = [
    1,
    2,
    3,
    4,
    5,
    6,
    // 7,
    // 8,
    // 9,
    // 10,
    // 11,
    // 12,
    // 13,
    // 14,
    // 15,
    // 16,
    // 17,
    // 18,
    // 19,
    // 20,
    // 21,
  ].mapIndexed((i, e) {
    List<int> colors = List.generate(
        21,
        (index) =>
            int.parse('0xFF${Random().nextInt(0x1000000).toRadixString(16)}'));
    var color = colors[i];
    return LayoutBuilder(
      builder: (context, bound) {
        return Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10))),

            ///content here
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(paddingDefault),
                  child: LayoutBuilder(builder: (context, bond) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(color: Color(color).darken(10)),
                      child: ImageTile(
                          image: null, index: i, width: 300, height: 300),
                    );
                  })),
            ),

            ///add floating image here
            Positioned(
              bottom: bound.maxHeight * 0.2,
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: bound.maxWidth * 0.4,
                  constraints: BoxConstraints(maxWidth: bound.maxWidth * 0.4),
                  child: Image.asset(
                    'assets/images/onBoarding_1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    buttonCarouselController = CarouselController();
    // _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 10,
        //   child: PageView.builder(
        //       controller: _pageController,
        //       itemCount: child.length,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           child: child[index],
        //         );
        //       }),
        // ),
        CarouselSlider(
          items: child,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: Get.height * 0.3,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: 2,
            onPageChanged: (index, reason) {
              setState(() {
                //   _pageController.animateToPage(index,
                //       duration: const Duration(milliseconds: 300),
                //       curve: Curves.easeInOut);
                _current = index;
              });
            },
          ),
        ),
        height10(),
        CarouselIndicator(count: child.length, index: _current),
      ],
    );
  }
}

/// image slider
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Generate a list of widgets. You can use another way
  List<Widget> widgets = List.generate(
    10,
    (index) => ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      child: Image.network(
        'https://source.unsplash.com/random/200x200/?wristwatch,$index', //Images stored in assets folder
        fit: BoxFit.fill,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var screenWidth = 600;
    var screenHeight = 500;
    return SizedBox(
      height: min(screenWidth / 3.3 * (16 / 9), screenHeight * .9),
      child: OverlappedCarousel(
        widgets: widgets, //List of widgets
        currentIndex: 2,
        onClicked: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You clicked at $index"),
            ),
          );
        },
      ),
    );
  }
}

class OverlappedCarousel extends StatefulWidget {
  final List<Widget> widgets;
  final Function(int) onClicked;
  final int? currentIndex;

  const OverlappedCarousel(
      {super.key,
      required this.widgets,
      required this.onClicked,
      this.currentIndex});

  @override
  _OverlappedCarouselState createState() => _OverlappedCarouselState();
}

class _OverlappedCarouselState extends State<OverlappedCarousel> {
  double currentIndex = 2;

  @override
  void initState() {
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex!.toDouble();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                var indx = currentIndex - details.delta.dx * 0.02;
                if (indx >= 1 && indx <= widget.widgets.length - 3) {
                  currentIndex = indx;
                }
              });
            },
            onPanEnd: (details) {
              setState(() {
                currentIndex = currentIndex.ceil().toDouble();
              });
            },
            child: OverlappedCarouselCardItems(
              cards: List.generate(
                widget.widgets.length,
                (index) => CardModel(id: index, child: widget.widgets[index]),
              ),
              centerIndex: currentIndex,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              onClicked: widget.onClicked,
            ),
          );
        },
      ),
    );
  }
}

class OverlappedCarouselCardItems extends StatelessWidget {
  final List<CardModel> cards;
  final Function(int) onClicked;
  final double centerIndex;
  final double maxHeight;
  final double maxWidth;

  const OverlappedCarouselCardItems({
    super.key,
    required this.cards,
    required this.centerIndex,
    required this.maxHeight,
    required this.maxWidth,
    required this.onClicked,
  });

  double getCardPosition(int index) {
    final double center = maxWidth / 2;
    final double centerWidgetWidth = maxWidth / 4;
    final double basePosition = center - centerWidgetWidth / 2 - 12;
    final distance = centerIndex - index;

    final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + centerWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2) -
            (nearWidgetWidth - farWidgetWidth) *
                ((distance - distance.floor()));
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2);
      }
    }
  }

  double getCardWidth(int index) {
    final double distance = (centerIndex - index).abs();
    final double centerWidgetWidth = maxWidth / 2;
    final double nearWidgetWidth = centerWidgetWidth / 5 * 4.5;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3.5;

    if (distance >= 0.0 && distance < 1.0) {
      return centerWidgetWidth -
          (centerWidgetWidth - nearWidgetWidth) * (distance - distance.floor());
    } else if (distance >= 1.0 && distance < 2.0) {
      return nearWidgetWidth -
          (nearWidgetWidth - farWidgetWidth) * (distance - distance.floor());
    } else {
      return farWidgetWidth;
    }
  }

  Matrix4 getTransform(int index) {
    final distance = centerIndex - index;

    var transform = Matrix4.identity()
      ..setEntry(3, 2, 0.007)
      ..rotateY(-0.25 * distance)
      ..scale(1.25, 1.25, 1.25);
    if (index == centerIndex) transform.scale(1.05, 1.05, 1.05);
    return transform;
  }

  Widget _buildItem(CardModel item) {
    final int index = item.id;
    final width = getCardWidth(index);
    final height = maxHeight - 20 * (centerIndex - index).abs();
    final position = getCardPosition(index);
    final verticalPadding = width * 0.05 * (centerIndex - index).abs();

    return Positioned(
      left: position,
      child: Transform(
        transform: getTransform(index),
        alignment: FractionalOffset.center,
        child: Container(
          width: width.toDouble(),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          height: height > 0 ? height : 0,
          child: item.child,
        ),
      ),
    );
  }

  List<Widget> _sortedStackWidgets(List<CardModel> widgets) {
    for (int i = 0; i < widgets.length; i++) {
      if (widgets[i].id == centerIndex) {
        widgets[i].zIndex = widgets.length.toDouble();
      } else if (widgets[i].id < centerIndex) {
        widgets[i].zIndex = widgets[i].id.toDouble();
      } else {
        widgets[i].zIndex =
            widgets.length.toDouble() - widgets[i].id.toDouble();
      }
    }
    widgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return widgets.map((e) {
      double distance = (centerIndex - e.id).abs();
      if (distance >= 0 && distance <= 3) {
        return _buildItem(e);
      } else {
        return Container();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: _sortedStackWidgets(cards),
      ),
    );
  }
}

class CardModel {
  final int id;
  double zIndex;
  final Widget? child;

  CardModel({required this.id, this.zIndex = 0.0, this.child});
}
