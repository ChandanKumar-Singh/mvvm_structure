import 'dart:async';
import 'dart:math';

import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/color.dart';
import '/utils/my_logger.dart';
import 'package:random_name_generator/random_name_generator.dart';

import '../../../../components/global_utils.dart';
import '../../../../components/live_chat_toast.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../utils/picture_utils.dart';
import '../../../../utils/sized_utils.dart';
import '../../../../utils/text.dart';

class AuctionDetailController extends GetxController {
  //TODO: Implement AuctionDetailController

  final count = 0.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void increment() => count.value++;

  runBidsToastTimer(BuildContext context) {
    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      bool isBid = Random().nextBool();
      if (isBid) {
        var randomNames = RandomNames(Zone.us).fullName();
        var amount =
            formatMoney(Random().nextDouble() * 1000000, fractionDigits: 2)
                .output
                .symbolOnLeft;
        var toast = MyToastModel(null, ToastType.success,
            child: Container(
              decoration: BoxDecoration(
                  color: getTheme(context).primaryColor.darken(60),
                  borderRadius: BorderRadius.circular(10)),
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
        try {
          if (context.mounted) {
            context.showToast<MyToastModel>(toast);
          }
        } catch (e) {
          logger.e('Error showToast: $e');
        }
      }
    });
  }
}
