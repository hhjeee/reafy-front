import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/dialog/stop_dialog.dart';
import 'package:reafy_front/src/pages/board.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/pages/map.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/time_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';
import 'package:reafy_front/src/repository/coin_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:showcaseview/showcaseview.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _floatingController;
  Animation<double>? _floatingAnimation;
  // late StopwatchProvider stopwatch;
  int? userCoin;
  bool _isBambooSelected = false;
  bool showBambooNotification = false;
  final GlobalKey keyBambooIcon = GlobalKey();
  final GlobalKey keyMapIcon = GlobalKey();
  final GlobalKey keyItemIcon = GlobalKey();
  final GlobalKey keyStartComponent = GlobalKey();
  late TutorialCoachMark tutorialCoachMark;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkIfFirstLaunch();
    });

    // stopwatch = StopwatchProvider();
    // WidgetsBinding.instance.addObserver(stopwatch);

    _floatingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _floatingController!,
        curve: Curves.easeInOut,
      ),
    );

    loadUserCoin();
    Future.microtask(
        () => Provider.of<CoinProvider>(context, listen: false).updateCoins());

    Future.microtask(() {
      final timeProvider = Provider.of<TimeProvider>(context, listen: false);
      timeProvider.getTimes();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ItemPlacementProvider>(context, listen: false)
          .fetchDataAndUseActivatedItems();
    });
  }

  @override
  void dispose() {
    _floatingController?.dispose();
    // WidgetsBinding.instance.removeObserver(stopwatch);
    // stopwatch.dispose();
    super.dispose();
  }

  Future<void> checkIfFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      ShowCaseWidget.of(context).startShowCase([
        keyBambooIcon,
        keyMapIcon,
        keyItemIcon,
        keyStartComponent,
      ]);
      prefs.setBool('isFirstLaunch', false);
    }
  }

  Future<void> loadUserCoin() async {
    try {
      int coin = await getUserCoin();
      setState(() {
        userCoin = coin;
      });
    } catch (e) {
      print('coin 에러 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
    final timeProvider = Provider.of<TimeProvider>(context);
    final size = MediaQuery.of(context).size;
    Widget _memo() {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
            onTap: () {
              Get.to(() => Board());
            },
            child: Stack(children: [
              ImageData(
                IconsPath.home_bubble,
                width: size.width * 0.43,
                height: size.height * 0.15,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: size.width * 0.04),
                  width: size.width * 0.43,
                  height: size.height * 0.13,
                  child: Center(
                      child: Transform.scale(
                    scale: 1.0,
                    child: Lottie.asset(
                      'assets/lottie/Memo.json',
                      width: 70,
                      height: 70,
                      frameRate: FrameRate(10000000),
                    ),
                  )))
            ]))
      ]);
    }

    Widget _get_bamboo({required VoidCallback onSelected}) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
            onTap: () {
              onSelected();
              Get.to(() => BambooMap());
              setState(() {
                //   final stopwatchProvider =
                //       Provider.of<StopwatchProvider>(context, listen: false);
                _isBambooSelected = false;
                Provider.of<StopwatchProvider>(context)
                    .hideBambooNotification();
              });
            },
            child: Stack(children: [
              ImageData(
                IconsPath.home_bubble_yellow,
                width: size.width * 0.43,
                height: size.height * 0.15,
              ),
              Container(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  width: size.width * 0.43,
                  height: size.height * 0.13,
                  child: Center(
                      child: Column(children: [
                    ImageData(
                      IconsPath.bambooicon,
                      width: 45,
                      height: 45,
                    ),
                    Text(
                      '대나무가 자랐어요',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
                  ])))
            ]))
      ]);
    }

    Widget _stopbutton(Size size) {
      return Center(
          child: GestureDetector(
              onTap: () {
                Provider.of<StopwatchProvider>(context).pause();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StopDialog();
                  },
                );
              },
              child: Container(
                  width: size.width * 0.87,
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: yellow,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "이제 그만 읽을래요!", //"독서 마치기"
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
                  ))));
    }

    Widget _time(todayTime, totalTime, size) {
      String displayTodayTime;
      if (todayTime != null) {
        if (todayTime >= 3600) {
          // 1시간 이상일 경우
          int hours = todayTime ~/ 3600;
          int minutes = (todayTime % 3600) ~/ 60;
          displayTodayTime = '$hours시간 $minutes분';
        } else if (todayTime >= 60) {
          // 1분 이상 1시간 미만일 경우
          int minutes = todayTime ~/ 60;
          int seconds = todayTime % 60;
          displayTodayTime = '$minutes분 $seconds초';
        } else {
          // 1분 미만일 경우
          displayTodayTime = '$todayTime초';
        }
      } else {
        displayTodayTime = '0초';
      }

      String displayTotalTime;
      if (totalTime != null && totalTime.isNotEmpty) {
        int totalMinutes = int.parse(totalTime);
        if (totalMinutes >= 60) {
          int hours = totalMinutes ~/ 60;
          int minutes = totalMinutes % 60;
          displayTotalTime = '${hours}시간 ${minutes}분';
        } else {
          displayTotalTime = '${totalMinutes}분';
        }
      } else {
        displayTotalTime = '0분';
      }

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.425,
              height: size.height * 0.07,
              padding: EdgeInsets.only(left: size.width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xfffaf9f7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ImageData(IconsPath.today,
                      isSvg: true,
                      width: size.width * 0.1,
                      height: size.width * 0.1),
                  SizedBox(width: size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        displayTodayTime,
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Container(
              width: size.width * 0.425,
              height: size.height * 0.07,
              padding: EdgeInsets.only(left: size.width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color(0xfffaf9f7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ImageData(IconsPath.total,
                      isSvg: true,
                      width: size.width * 0.1,
                      height: size.width * 0.1),
                  SizedBox(width: size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Month",
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        displayTotalTime,
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _shadow() {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            width: 120,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(0, 100))
                ]),
          ));
    }

    Widget _buildCharacter() {
      return Container(
        width: size.width * 0.47,
        height: size.height * 0.3,
        child: ImageData(
            Provider.of<StopwatchProvider>(context).status == Status.running
                ? IconsPath.character_reading
                : IconsPath.character),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffaf9f7),
          elevation: 0,
          leadingWidth: 110,
          toolbarHeight: 44,
          leading: Container(
            padding: EdgeInsets.only(left: 16),
            child: Showcase(
              key: keyBambooIcon,
              description: '대나무 개수를 확인할 수 있어요',
              tooltipBackgroundColor: Colors.transparent,
              textColor: Colors.white,
              targetBorderRadius: BorderRadius.circular(100),
              descTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w800),
              showArrow: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageData(IconsPath.bamboo,
                      isSvg: true, width: 44, height: 44),
                  Text(
                    Provider.of<CoinProvider>(context).coins.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Showcase(
              key: keyMapIcon,
              description: "대나무를 획득하고 \n남은 시간을 확인할 수 있어요",
              tooltipBackgroundColor: Colors.transparent,
              textColor: Colors.white,
              targetBorderRadius: BorderRadius.circular(100),
              descTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w800),
              descriptionAlignment: TextAlign.center,
              showArrow: false,
              child: IconButton(
                iconSize: 44,
                padding: EdgeInsets.only(right: 0),
                icon: ImageData(IconsPath.map_icon, isSvg: true),
                onPressed: () {
                  Get.to(() => BambooMap());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Showcase(
                key: keyItemIcon,
                description: '아이템을 구매하고 관리할 수 있어요',
                tooltipBackgroundColor: Colors.transparent,
                textColor: Colors.white,
                targetBorderRadius: BorderRadius.circular(100),
                descTextStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w800),
                showArrow: false,
                child: IconButton(
                  iconSize: 44,
                  padding: EdgeInsets.only(right: 0),
                  icon: ImageData(IconsPath.item, isSvg: true),
                  onPressed: () {
                    Get.to(() => ItemShop());
                  },
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
              width: size.width,
              decoration: BoxDecoration(color: Color(0xfffff9c1)),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFAF9F7),
                      Color.fromRGBO(250, 249, 247, 0.0),
                    ],
                  ),
                ),
                child: AnimatedBuilder(
                    animation: _floatingAnimation!,
                    builder: (context, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Consumer<StopwatchProvider>(
                            builder: (context, stopwatch, child) {
                              if (stopwatch.itemCnt > 0 &&
                                  !_isBambooSelected &&
                                  stopwatch.showBambooNotification) {
                                return _get_bamboo(onSelected: () {
                                  setState(() {
                                    _isBambooSelected = true;
                                  });
                                });
                              } else {
                                return _memo();
                              }
                            },
                          ),
                          Consumer<ItemPlacementProvider>(
                              builder: (context, itemPlacementProvider, child) {
                            return Center(
                                child: Container(
                                    width: size.width,
                                    height: size.height * 0.4,
                                    child: Stack(
                                      children: [
                                        //// Rug
                                        Positioned(
                                          top: size.height * 0.34,
                                          left: size.width * 0.25,
                                          child: Container(
                                            width: size.width * 0.5,
                                            height: size.height * 0.04,
                                            child: ImageData(
                                                itemPlacementProvider
                                                    .rug.imagePath,
                                                width: size.width * 0.5,
                                                height: size.height * 0.04),
                                          ),
                                        ),
                                        // Shadow
                                        Positioned(
                                          top: size.height * 0.22,
                                          left: size.width * 0.26,
                                          child: _shadow(),
                                        ),

                                        //// BookShelf
                                        Positioned(
                                          top: size.height * 0.032,
                                          left: size.width * 0.03,
                                          child: Container(
                                              width: size.width * 0.28,
                                              height: size.height * 0.27,
                                              child: ImageData(
                                                  itemPlacementProvider
                                                      .bookshelf.imagePath,
                                                  width: size.width * 0.28,
                                                  height: size.height * 0.27)),
                                        ),
                                        // Character
                                        Positioned(
                                          top: size.height * 0.075 +
                                              _floatingAnimation!.value,
                                          left: (SizeConfig.screenWidth -
                                                  size.width * 0.47) /
                                              2,
                                          child: _buildCharacter(),
                                        ),
                                        //// Clock
                                        Positioned(
                                          left: size.width * 0.42,
                                          top: 0,
                                          child: Container(
                                              width: size.width * 0.16,
                                              height: size.height * 0.075,
                                              child: ImageData(
                                                  itemPlacementProvider
                                                      .clock.imagePath,
                                                  width: size.width * 0.16,
                                                  height: size.height * 0.075)),
                                        ),
                                        //// Window
                                        Positioned(
                                          top: size.height * 0.04,
                                          right: size.width * 0.03,
                                          child: Container(
                                            width: size.width * 0.25,
                                            height: size.height * 0.12,
                                            child: ImageData(
                                              itemPlacementProvider
                                                  .window.imagePath,
                                              width: size.width * 0.25,
                                              height: size.height * 0.12,
                                            ),
                                          ),
                                        ),
                                        //// Others
                                        Positioned(
                                          right: size.width * 0.058,
                                          top: size.height * 0.18,
                                          child: Container(
                                            width: size.width * 0.23,
                                            height: size.height * 0.13,
                                            child: ImageData(
                                                itemPlacementProvider
                                                    .others.imagePath,
                                                width: size.width * 0.23,
                                                height: size.height * 0.13),
                                          ),
                                        ),
                                      ],
                                    )));
                          }),
                          Showcase(
                            key: keyStartComponent,
                            description: '타이머 시작 버튼을 클릭하면 \n 시간이 자동으로 측정돼요',
                            targetPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            tooltipBackgroundColor: Colors.transparent,
                            textColor: Colors.white,
                            descTextStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w800),
                            showArrow: false,
                            descriptionAlignment: TextAlign.center,
                            tooltipPosition: TooltipPosition.top,
                            targetBorderRadius: BorderRadius.circular(20),
                            child: Column(
                              children: [
                                Provider.of<StopwatchProvider>(context)
                                            .status ==
                                        Status.running
                                    ? _stopbutton(size)
                                    : _time(timeProvider.todayTime,
                                        timeProvider.totalTime, size),
                                const SizedBox(height: 15),
                                Center(child: StopwatchWidget()),
                              ],
                            ),
                          ),
                          Spacer()
                        ],
                      );
                    }),
              )),
        ));
  }
}
