import 'package:flutter/material.dart';

/// screen size, color
///
const defaultPadding = 20.0;
const cartBarHeight = 100.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFF5F5F5);
const primaryColor = Color(0xFFFFD747);
const gray = Color(0xFF808080);

const panelTransition = Duration(milliseconds: 500);

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
