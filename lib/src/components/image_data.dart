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
  static String get bamboo => 'assets/svg/appbar_bamboo.svg';

  static String get item => 'assets/svg/appbar_item.svg';
  static String get play => 'assets/svg/play.svg';
  static String get pause => 'assets/svg/pause.svg';
  static String get stop => 'assets/svg/stop.svg';
  static String get statistic => 'assets/svg/statistic.svg';
  static String get star => 'assets/svg/star.svg';
  static String get Logout => 'assets/svg/logout.svg';
  static String get Team => 'assets/svg/team.svg';
  static String get Pencil => 'assets/svg/pencil.svg';
  static String get pencil_black => 'assets/svg/pencil_black.svg';
  static String get trash_can => 'assets/svg/trash_can.svg';
  static String get line => 'assets/svg/line.svg';
  static String get startbutton => 'assets/images/Button.png';
  static String get runningbutton => 'assets/images/Runningbutton.png';
  static String get nextarrow => 'assets/svg/nextarrow.svg';
  static String get add => 'assets/svg/add.svg';
  static String get delete => 'assets/svg/delete.svg';
  static String get x => 'assets/svg/x.svg';
  static String get team_link => 'assets/svg/team_link.svg';
  static String get state_1 => 'assets/images/state_1.png';
  static String get state_2 => 'assets/images/state_2.png';
  static String get state_3 => 'assets/images/state_3.png';
  static String get state_4 => 'assets/images/state_4.png';

  static String get intro => 'assets/images/intro.png';

  static String get bookshelf => 'assets/svg/bookshelf.svg';

  static String get character => 'assets/images/poobao.png';

  static String get book => 'assets/images/book.png';
  static String get hill => 'assets/images/hill.png';
  static String get bamboo_bar => 'assets/images/bamboo_bar.png';
  //static String get poobao_shadow => 'assets/images/poobao_shadow.png';
  static String get poobao_shadow => 'assets/svg/poobao_shadow.svg';

  static String get family => 'assets/images/team.png';
}
