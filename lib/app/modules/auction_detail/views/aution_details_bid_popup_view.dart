// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import '/app/modules/auction_detail/controllers/auction_detail_controller.dart';
import '/constants/asset_constants.dart';
import '/utils/color.dart';
import '/utils/picture_utils.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:random_name_generator/random_name_generator.dart';

import '../../../../components/global_utils.dart';
import '../../../../components/live_chat_toast.dart';

/// [AutionDetailsBidPopupView] is the view of auction details bid popup
class AutionDetailsBidPopupView extends GetWidget {
  const AutionDetailsBidPopupView({Key? key}) : super(key: key);
  Widget _buildItem(
    BuildContext context,
    MyToastModel item,
    int index,
    Animation<double> animation,
  ) {
    return ToastItem(
      animation: animation,
      item: item,
      onTap: () => context.hideToast(
        item,
        (context, animation) => _buildItem(context, item, index, animation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionDetailController>(
        init: AuctionDetailController(),
        builder: (acutionDetailController) {
          return ToastListOverlay<MyToastModel>(
            position: Alignment.topRight,
            reverse: false,
            limit: 7,
            timeoutDuration: const Duration(seconds: 2),
            // width: 400,
            itemBuilder: (
              BuildContext context,
              MyToastModel item,
              int index,
              Animation<double> animation,
            ) =>
                Builder(builder: (context) {
              return _buildItem(context, item, index, animation);
            }),
            child: _BuildBody(acutionDetailController: acutionDetailController),
          );
        });
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody({super.key, required this.acutionDetailController});
  final AuctionDetailController acutionDetailController;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  @override
  void initState() {
    super.initState();
    widget.acutionDetailController.runBidsToastTimer(context);
  }

  @override
  void dispose() {
    super.dispose();
    widget.acutionDetailController.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height -
                  ((MediaQuery.of(context).viewInsets.bottom == 0
                      ? (kBottomNavigationBarHeight * 2)
                      : kBottomNavigationBarHeight)),
              width: Get.width,
              margin: EdgeInsetsDirectional.only(
                top: kToolbarHeight + spaceDefault,
                bottom: MediaQuery.of(context).viewInsets.bottom == 0
                    ? kBottomNavigationBarHeight + spaceDefault
                    : 0,
                start: spaceDefault * 2,
                end: spaceDefault * 2,
              ),
              child: LayoutBuilder(builder: (context, bound) {
                double paddingDefault = bound.maxWidth * 0.05;
                double imageMargin = bound.maxWidth * 0.1;
                double closeIconSize = bound.maxHeight * 0.1;
                double imageHeight = bound.maxWidth - imageMargin * 2;
                double trackThickness =
                    bound.maxWidth * 0.02 > 10 ? 10 : bound.maxWidth * 0.02;
                double bordRadius = 10;
                double fontSize = 16;
                return Stack(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () => Get.back(),
                            child: height20(imageHeight / 2)),

                        ///body
                        ///imageMargin * 3 + closeIconSize+ paddingDefault+ paddingDefault
                        Expanded(
                          child: GestureDetector(
                            onTap: () => primaryFocus?.unfocus(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Scaffold(
                                body: Column(
                                  children: [
                                    height10(imageHeight / 2),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsetsDirectional.all(
                                            paddingDefault),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _BidTextField(
                                              fontSize: fontSize,
                                              bordRadius: bordRadius,
                                              bound: bound,
                                            ),
                                            height5(paddingDefault),

                                            ///bid history
                                            Expanded(
                                              child:
                                                  // Scrollbar(
                                                  //   thickness:
                                                  //       trackThickness,
                                                  //   thumbVisibility: true,
                                                  //   trackVisibility: true,
                                                  //   interactive: true,
                                                  //   radius: const Radius
                                                  //       .circular(20),
                                                  //   scrollbarOrientation:
                                                  //       ScrollbarOrientation
                                                  //           .right,
                                                  //   child:
                                                  ListView.separated(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        end:
                                                            trackThickness * 2),
                                                itemCount: 15,
                                                itemBuilder: (ctx, index) {
                                                  var randomNames =
                                                      RandomNames(Zone.us);
                                                  return ListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: Container(
                                                      width: paddingDefault * 2,
                                                      height:
                                                          paddingDefault * 2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white10,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            'https://picsum.photos/${(paddingDefault * 2).toInt()}/${(paddingDefault * 2).toInt()}?random=$index',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    title: capText(randomNames
                                                        .manFullName()),
                                                    trailing: capText(formatMoney(
                                                            Random().nextDouble() *
                                                                1000000,
                                                            fractionDigits: 2)
                                                        .output
                                                        .symbolOnLeft),
                                                  );
                                                },
                                                separatorBuilder: (ctx,
                                                        index) =>
                                                    const Divider(
                                                        height: 1,
                                                        color: Colors.white10),
                                              ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///close icon
                        if (MediaQuery.of(context).viewInsets.bottom == 0)
                          _buildCloseButton(paddingDefault, closeIconSize),
                      ],
                    ),

                    ///upper image
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: imageHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: imageHeight,
                            decoration: BoxDecoration(
                              color: getTheme().primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://picsum.photos/${imageHeight.toInt()}/${imageHeight.toInt()}?random=1'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildCloseButton(
      double paddingDefault, double closeIconSize) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: double.maxFinite,
        color: Colors.transparent,
        child: Column(
          children: [
            height20(paddingDefault),

            ///close icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: closeIconSize,
                  height: closeIconSize,
                  decoration: BoxDecoration(
                      color: getTheme().primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BidTextField extends StatefulWidget {
  const _BidTextField({
    super.key,
    required this.fontSize,
    required this.bordRadius,
    required this.bound,
  });
  final BoxConstraints bound;
  final double fontSize;
  final double bordRadius;

  @override
  State<_BidTextField> createState() => _BidTextFieldState();
}

class _BidTextFieldState extends State<_BidTextField> {
  final TextEditingController _controller = TextEditingController();
  bool biding = false;

  bidAmount() async {
    primaryFocus?.unfocus();
    double amount = double.tryParse(_controller.text) ?? 0;
    if (amount > 0) {
      setState(() {
        biding = true;
      });
      await Future.delayed(const Duration(seconds: 0));
      var randomNames = RandomNames(Zone.us).fullName();
      var amount =
          formatMoney(Random().nextDouble() * 1000000, fractionDigits: 2)
              .output
              .symbolOnLeft;
      var toast = MyToastModel(null, ToastType.success,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                capText(randomNames),
                width10(),
                capText(amount),
                width5(),
                assetSvg(MySvg.diamond, width: 10, height: 10)
              ],
            ),
          ));
      context.showToast<MyToastModel>(toast);
      // await Future.delayed(const Duration(seconds: 3));
      // context.hideToast<MyToastModel>(toast,
      //     (context, animation) => ToastItem(animation: animation, item: toast));

      setState(() {
        biding = false;
        _controller.clear();
      });
    } else {
      Get.snackbar(
        'Error',
        'Please enter valid amount',
        titleText: capText('Error'),
        messageText: capText('Please enter valid amount'),
        backgroundColor: Colors.red[300],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        bodyMedText('Top bidders', fontWeight: FontWeight.bold),
        width10(),
        Expanded(
            child: Stack(
          children: [
            /// bid amount field
            TextFormField(
              controller: _controller,
              style: getTheme()
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: widget.fontSize, color: Colors.white),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                NoDoubleDecimalFormatter(allowOneDecimal: 1),
              ],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) => bidAmount(),
              decoration: InputDecoration(
                // isDense: true,
                contentPadding: EdgeInsetsDirectional.only(
                    start: (getTheme().textTheme.bodySmall?.fontSize ?? 10) * 2,
                    end: widget.bound.maxWidth * 0.2,
                    top: 5,
                    bottom: 5),
                filled: true,
                fillColor: Colors.white10,
                hintText: 'Enter amount',
                hintStyle: getTheme().inputDecorationTheme.hintStyle,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.bordRadius),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.bordRadius),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.bordRadius),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),

            ///prefix icon
            Positioned(
              top: 0,
              bottom: 0,
              width: (getTheme().textTheme.bodySmall?.fontSize ?? 10) * 2,
              child: Container(
                margin: const EdgeInsets.all(2),
                width: 10,
                height: 10,
                child: Center(child: capText('\$')),
              ),
            ),

            ///suffix icon
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: widget.bound.maxWidth * 0.2,
              child: GestureDetector(
                onTap: () {
                  print('werghjkiuytffgbn ${_controller.text}');
                },
                child: GestureDetector(
                  onTap: biding ? null : () => bidAmount(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: biding ? Colors.grey : kPrimaryColor5,
                      borderRadius:
                          BorderRadius.circular(widget.bordRadius - 2),
                    ),
                    margin: const EdgeInsets.all(2),
                    width: 10,
                    height: 10,
                    child: Center(
                        child: biding
                            ? CupertinoActivityIndicator(
                                radius: widget.fontSize / 2)
                            : capText('Bid',
                                color: Colors.white,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
