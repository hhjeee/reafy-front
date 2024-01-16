import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  final double? height;
  final bool isSvg;

  ImageData(
    this.icon, {
    Key? key,
    this.width = 44,
    this.height = 44,
    this.isSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        icon, // SVG 파일 경로
        width: width,
        height: height,
      );
    } else {
      return Image.asset(icon, // 이미지 파일 경로
          width: width,
          height: height);
    }
  }
}

class IconsPath {
  // login 화면
  static String get bubble => 'assets/images/bubble.png';
  static String get title_logo => 'assets/images/title_logo.png';
  static String get login_character => 'assets/images/login_character.png';
  static String get login_button => 'assets/images/kakao_login.png';

  // 하단 바
  static String get homeOff => 'assets/svg/bottombar_home_off.svg';
  static String get homeOn => 'assets/svg/bottombar_home_on.svg';

  static String get bookOff => 'assets/svg/bottombar_book_off.svg';
  static String get bookOn => 'assets/svg/bottombar_book_on.svg';

  static String get mypageOff => 'assets/svg/bottombar_mypage_off.svg';
  static String get mypageOn => 'assets/svg/bottombar_mypage_on.svg';

  // 상단 바
  static String get bamboo => 'assets/svg/bamboo.svg';
  static String get map_icon => 'assets/svg/map.svg';
  static String get item => 'assets/svg/item.svg';

  // 스탑워치
  static String get play => 'assets/svg/play.svg';
  static String get pause => 'assets/svg/pause.svg';
  static String get stop => 'assets/svg/stop.svg';
  static String get startbutton => 'assets/images/startbutton.png';
  static String get runningbutton => 'assets/images/runningbutton.png';
  // 홈화면
  static String get home_bubble => 'assets/images/home_bubble.png';

  //프로필
  static String get statistic => 'assets/svg/statistic.svg';
  static String get star => 'assets/svg/star.svg';
  static String get Logout => 'assets/svg/logout.svg';
  static String get Team => 'assets/svg/team.svg';
  static String get pencil => 'assets/svg/pencil.svg';

  //책 상세
  static String get pencil_green => 'assets/svg/pencil_green.svg';
  static String get trash_can => 'assets/svg/trash_can.svg';
  static String get line => 'assets/svg/line.svg';

  static String get left => 'assets/svg/left.svg';
  static String get right => 'assets/svg/right.svg';
  static String get nextarrow => 'assets/svg/nextarrow.svg';
  static String get backarrow => 'assets/svg/backarrow.svg';
  static String get add => 'assets/svg/add.svg';
  static String get delete => 'assets/svg/delete.svg';
  static String get x => 'assets/svg/x.svg';
  static String get team_link => 'assets/svg/team_link.svg';
  static String get dropdown => 'assets/svg/dropdown_button.svg';
  static String get check => 'assets/svg/check.svg';
  static String get check_green => 'assets/svg/check_green.svg';
  static String get done => 'assets/svg/done_button.svg';
  static String get favorite => 'assets/svg/book_favorite.svg';
  static String get nonFavorite => 'assets/svg/book_nonFavorite.svg';

  // 온보딩
  static String get state_1 => 'assets/images/state_1.png';
  static String get state_2 => 'assets/images/state_2.png';
  static String get state_3 => 'assets/images/state_3.png';
  static String get state_4 => 'assets/images/state_4.png';
  //static String get intro => 'assets/images/intro.png';

  static String get bookshelf => 'assets/svg/bookshelf.svg';

  static String get character => 'assets/images/poobao.png';
  static String get character_reading => 'assets/images/poobao_reading.png';
  static String get character_book => 'assets/images/poobao_book.png';
  static String get character_empty => 'assets/images/poobao_empty.png';

  static String get character2 => 'assets/images/poobao_temp.png';

  static String get book => 'assets/images/book.png';
  static String get hill => 'assets/images/hill.png';
  static String get bamboo_bar => 'assets/images/bamboo_bar.png';
  //static String get poobao_shadow => 'assets/images/poobao_shadow.png';
  static String get poobao_shadow => 'assets/svg/poobao_shadow.svg';
  static String get book_leaves => 'assets/images/book_leaves.png';
  static String get team_img => 'assets/images/team_poobao.png';
  static String get profile => 'assets/images/profile.png';

  static String get lock => 'assets/images/lock.png';
  static String get select_nothing => 'assets/images/select_nothing.png';

  static String get home_graffic => 'assets/images/home_graffic.png';
  static String get map => 'assets/images/map.png';
  static String get today => 'assets/svg/today_time.svg';
  static String get total => 'assets/svg/total_time.svg';

  static String get add_back => 'assets/images/addbook_background.png';

  // 맵
  static String get bamboomap => 'assets/images/bamboo_map.png';
  static String get bambooicon => 'assets/images/bamboo_icon.png';
  static String get map_bubble => 'assets/svg/map_bubble.svg';

  static String get bamboomap_day => 'assets/images/bamboomap_day.png';
  static String get bamboomap_night => 'assets/images/bamboomap_night.png';
  static String get back_arrow => 'assets/svg/back_arrow.svg';

  // 메모

  static String get memo_ex => 'assets/images/memo_example.png';
  static String get add_memo => 'assets/svg/add_memo.svg';
  static String get memo_date => 'assets/svg/memo_date.svg';
  static String get memo_book => 'assets/svg/memo_book.svg';
  static String get memo_tag => 'assets/svg/memo_tag.svg';
  static String get add_tag => 'assets/svg/add_tag.svg';
  static String get memo_pic => 'assets/svg/memo_picture.svg';
  static String get shelf_right => 'assets/svg/shelf_right.svg';
  static String get menu => 'assets/svg/dots.svg';

  // 아이템
  static String get crying => 'assets/images/crying.png';
}

class FloatingSVG extends StatefulWidget {
  final String svgAssetPath;
  final Duration duration;
  final double verticalRange;

  const FloatingSVG({
    Key? key,
    required this.svgAssetPath,
    this.duration = const Duration(seconds: 2),
    this.verticalRange = 20.0,
  }) : super(key: key);

  @override
  _FloatingSVGState createState() => _FloatingSVGState();
}

class _FloatingSVGState extends State<FloatingSVG>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation =
        Tween<double>(begin: 0, end: widget.verticalRange).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: SvgPicture.asset(widget.svgAssetPath), // Load SVG
    );
  }
}
