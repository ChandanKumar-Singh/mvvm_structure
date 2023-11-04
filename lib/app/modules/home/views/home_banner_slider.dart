import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/color.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:collection/collection.dart';

import '../../../routes/app_pages.dart';

class HomeBannerSlider extends StatelessWidget {
  final CarouselController buttonCarouselController = CarouselController();

  HomeBannerSlider({super.key});
  List<int> colors = List.generate(
      5,
      (index) =>
          int.parse('0xFF${Random().nextInt(0x1000000).toRadixString(16)}'));

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [1, 2, 3, 4, 5].mapIndexed((i, e) {
      var color = colors[i];
      return Builder(
        builder: (BuildContext context) {
          return LayoutBuilder(
            builder: (context, bound) {
              return Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10))),

                  ///content here
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(paddingDefault),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(paddingDefault),
                          decoration:
                              BoxDecoration(color: Color(color).darken(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // bodyMedText('Title'),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: bound.maxWidth * 0.5),
                                      child: Wrap(
                                        children: [
                                          RichText(
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            text: TextSpan(
                                              //write ad text for watch bidding
                                              text:
                                                  'Bidding for the art piece  ',
                                              style: getTheme()
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),

                                              children: const <TextSpan>[
                                                TextSpan(
                                                    text: ' # (NFT)',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    bodyMedText('23h : 59m : 59s'),
                                  ],
                                ),
                              ),
                              height5(),
                              SizedBox(
                                height: bound.maxHeight * 0.2,
                                child: AspectRatio(
                                  aspectRatio: 4,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.autionDetail);
                                    },
                                    child: AutoSizeText(
                                      'Place a bid',
                                      minFontSize: 10,
                                      // presetFontSizes: [20, 18, 16, 14, 12, 10],
                                      style: getTheme().textTheme.displayLarge,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),

                  ///add image here
                  Positioned(
                    bottom: bound.maxHeight * 0.2,
                    top: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: bound.maxWidth * 0.4,
                        constraints:
                            BoxConstraints(maxWidth: bound.maxWidth * 0.4),
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
        },
      );
    }).toList();
    return CarouselSlider(
      items: child,
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
  }
}
