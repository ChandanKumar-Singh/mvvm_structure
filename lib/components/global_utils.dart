import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

import '../utils/sized_utils.dart';

///global page gradient
LinearGradient globalPageGradient() {
  return LinearGradient(
    colors: [
      Get.theme.primaryColor,
      Get.theme.scaffoldBackgroundColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

//global container
Container globalContainer({Widget? child, EdgeInsets? padding}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      gradient: globalPageGradient(),
    ),
    child: child,
  );
}

///global back button
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onTap,
  });
  final FutureOr<bool> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        bool result = true;
        if (onTap != null) {
          result = await onTap!();
        }
        if (result) {
          Get.back();
        }
      },
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }
}

///global appbar margin
EdgeInsetsDirectional appBarTopMargin() {
  return EdgeInsetsDirectional.only(
    top: (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android)
        ? 50
        : 0,
  );
}

///font awesome icon
FaIcon faIcon(IconData icon, {Color color = Colors.white70, double size = 15}) {
  return FaIcon(icon, color: color, size: 15);
}

///money formatter
MoneyFormatter formatMoney(
  double i, {
  int fractionDigits = 3,
  symbol = '\$',
  thousandSeparator = ',',
  decimalSeparator = '.',
  symbolAndNumberSeparator = ' ',
  compactFormatType = CompactFormatType.short,
}) {
  return MoneyFormatter(
      amount: i,
      settings: MoneyFormatterSettings(
        symbol: symbol,
        thousandSeparator: thousandSeparator,
        decimalSeparator: decimalSeparator,
        symbolAndNumberSeparator: symbolAndNumberSeparator,
        fractionDigits: fractionDigits,
        compactFormatType: compactFormatType,
      ));
}

/// Preview image
void previewImage(Image image) => showDialog(
    context: getContext, builder: (context) => Dialog(child: image));
