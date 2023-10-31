import 'package:flutter/material.dart';

/// screen size, color
///
const defaultPadding = 20.0;
const cartBarHeight = 100.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFFCFCFA);

const primaryColor = Color(0xFFFFD747);
const gray = Color(0xFF808080);
const green = Color(0xFF63B865);
const white = Color(0xFFffffff);
const panelTransition = Duration(milliseconds: 500);

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

//const mediaHeight = MediaQuery.of(context).size.height;
//const mediaWidth =  MediaQuery.of(context).size.width;

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
