import 'dart:async';

import 'package:flutter/material.dart';

/// screen size, color
///
const defaultPadding = 20.0;
const cartBarHeight = 100.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFFCFCFA);
const yellow_bg = Color(0xffFFF7D9);

const yellow = Color(0xFFFFD747);
const gray = Color(0xFF808080);
const green = Color(0xFF63B865);
const white = Color(0xFFffffff);
const yellow_light = Color(0xFFFFECA6);
const black = Color(0xff333333);
const dark_gray = Color(0xff666666);
const bg_gray = Color(0xfffaf9f7);
const disabled_box = Color(0xffebebeb);

const panelTransition = Duration(milliseconds: 500);

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

/*
class WidgetSize {
  static Future<Size> getSize(GlobalKey key) async {
    Completer<Size> completer = Completer<Size>();
    await WidgetsBinding.instance!.addPostFrameCallback((_) {
      try {
        RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
        Size size = renderBox.size;
        completer.complete(size);
      } catch (e) {
        completer.completeError(e);
      }
    });
    return completer.future;
  }
}
*/


// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
