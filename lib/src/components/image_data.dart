import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  final bool isSvg;
  ImageData(
    this.icon, {
    Key? key,
    this.width = 26,
    this.isSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        icon, // SVG 파일 경로
        width: width,
      );
    } else {
      return Image.asset(
        icon, // 이미지 파일 경로
        width: width,
      );
    }
  }
}

class IconsPath {
  static String get homeOff => 'assets/svg/bottombar_home_off.svg';
  static String get homeOn => 'assets/svg/bottombar_home_on.svg';
  static String get bookOff => 'assets/svg/bottombar_book_off.svg';
  static String get bookOn => 'assets/svg/bottombar_book_on.svg';
  static String get mypageOff => 'assets/svg/bottombar_mypage_off.svg';
  static String get mypageOn => 'assets/svg/bottombar_mypage_on.svg';
  static String get coin => 'assets/svg/appbar_coin.svg';
  static String get item => 'assets/svg/appbar_item.svg';
  static String get play => 'assets/images/play.png';
  static String get pause => 'assets/svg/pause.svg';
  static String get stop => 'assets/svg/stop.svg';
  static String get statistic => 'assets/svg/statistic.svg';
  static String get star => 'assets/svg/star.svg';

  static String get character => 'assets/images/test_character.png';
}
