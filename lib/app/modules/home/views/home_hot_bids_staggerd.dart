import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:money_formatter/money_formatter.dart';
import '/constants/asset_constants.dart';
import '/utils/color.dart';
import '/utils/picture_utils.dart';
import '/utils/sized_utils.dart';

import '../../../../components/random_image_tile.dart';
import '../../../../utils/text.dart';

class MasonryPage extends StatefulWidget {
  const MasonryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MasonryPage> createState() => _MasonryPageState();
}

class _MasonryPageState extends State<MasonryPage> {
  final rnd = Random();
  late List<int> extents;
  int crossAxisCount = 4;

  @override
  void initState() {
    super.initState();
    extents = List<int>.generate(32, (int index) {
      var num = (rnd.nextInt(10)).clamp(8, 10);
      return num;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///title
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: paddingDefault, vertical: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  titleLargeText('Hot Bids'),
                  width5(),
                  assetImages(MyPng.fire, height: 30, width: 30),
                ],
              ),
              bodyMedText('View All')
            ],
          ),
        ),
        MasonryGridView.count(
          padding: EdgeInsets.all(paddingDefault),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            final height = extents[index] * 27;
            var amount = MoneyFormatter(
                amount: 145678.9012345,
                settings: MoneyFormatterSettings(
                    symbol: '\$',
                    thousandSeparator: ',',
                    decimalSeparator: '.',
                    symbolAndNumberSeparator: ' ',
                    fractionDigits: 3,
                    compactFormatType: CompactFormatType.short));
            return LayoutBuilder(builder: (context, bound) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(paddingDefault),
                child: Stack(
                  children: [
                    ImageTile(
                        index: index,
                        imageWidth: 100,
                        height: height,
                        width: bound.maxWidth.toInt()),

                    ///content here
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: kPrimaryColor2,
                        padding: const EdgeInsets.all(8),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            ///icon
                            assetSvg(MySvg.diamond, height: 12, width: 12),
                            width5(),

                            ///amount
                            AutoSizeText(amount.output.symbolOnLeft),

                            ///time left
                            capText('23h : 59m : 59s'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
          itemCount: extents.length,
        ),
      ],
    );
  }
}

///
const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}
