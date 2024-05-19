import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/stop_dialog.dart';
import 'package:reafy_front/src/pages/board.dart';
import 'package:reafy_front/src/pages/itemshop.dart';
import 'package:reafy_front/src/components/stopwatch.dart';
import 'package:reafy_front/src/pages/map.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/provider/time_provider.dart';
import 'package:reafy_front/src/repository/timer_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';
import 'package:reafy_front/src/repository/coin_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _floatingController;
  Animation<double>? _floatingAnimation;
  late StopwatchProvider stopwatch;

  int? userCoin;
  bool _isBambooSelected = false;
  bool showBambooNotification = false;

  @override
  void initState() {
    super.initState();
    stopwatch = StopwatchProvider();
    WidgetsBinding.instance.addObserver(stopwatch);

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
    WidgetsBinding.instance.removeObserver(stopwatch);
    stopwatch.dispose();
    super.dispose();
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
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
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
                width: 170,
                height: 130,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 170,
                  height: 110,
                  child: Center(
                      child: Transform.scale(
                    scale: 1.0, // Adjust scale factor as needed
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BambooMap()),
              ).then((_) {
                setState(() {
                  final stopwatchProvider =
                      Provider.of<StopwatchProvider>(context, listen: false);
                  _isBambooSelected = false;
                  stopwatchProvider.showBambooNotification = false;
                });
                print(_isBambooSelected);
              });
            },
            child: Stack(children: [
              ImageData(
                IconsPath.home_bubble_yellow,
                width: 170,
                height: 130,
              ),
              Container(
                  padding: EdgeInsets.only(top: 25),
                  width: 170,
                  height: 110,
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

    Widget _stopbutton() {
      return Center(
          child: GestureDetector(
              onTap: () {
                stopwatch.pause();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StopDialog();
                  },
                );
              },
              child: Container(
                  width: 338,
                  height: 50,
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
                      "이제 그만 읽을래요",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
                  ))));
    }

    Widget _time(todayTime, totalTime) {
      String displayTodayTime;
      if (todayTime != null) {
        if (todayTime >= 3600) {
          // 1시간 이상일 경우
          int hours = todayTime ~/ 3600;
          int minutes = (todayTime % 3600) ~/ 60;
          int seconds = todayTime % 60;
          displayTodayTime = '$hours시간 $minutes분 $seconds초';
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
              width: 166,
              height: 60,
              padding: EdgeInsets.only(left: 10.0),
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
                      isSvg: true, width: 44, height: 44),
                  SizedBox(width: 10.0),
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
            SizedBox(width: 6),
            Container(
              width: 166,
              height: 60,
              padding: EdgeInsets.only(left: 10.0),
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
                      isSvg: true, width: 44, height: 44),
                  SizedBox(width: 10.0),
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
      // Replace with your character widget
      return Container(
        width: 186,
        height: 248,
        child: ImageData(stopwatch.status == Status.running
            ? IconsPath.character_reading
            : IconsPath.character),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffaf9f7),
          elevation: 0,
          leadingWidth: 90,
          toolbarHeight: 44,
          leading: Container(
              padding: EdgeInsets.only(left: 16),
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
              )),
          actions: [
            IconButton(
              iconSize: 44,
              padding: EdgeInsets.only(right: 0),
              icon: ImageData(IconsPath.map_icon, isSvg: true),
              onPressed: () {
                Get.to(() => BambooMap());
              },
            ),
            IconButton(
              padding: EdgeInsets.only(right: 16),
              iconSize: 44,
              icon: ImageData(IconsPath.item, isSvg: true),
              onPressed: () {
                Get.to(() => ItemShop());
              },
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
                            builder: (context, stopwatchProvider, child) {
                              if (stopwatchProvider.itemCnt > 0 &&
                                  !_isBambooSelected &&
                                  stopwatchProvider.showBambooNotification) {
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
                                    height: 332,
                                    child: Stack(
                                      children: [
                                        //// Rug
                                        Positioned(
                                          top: 276,
                                          left: 104,
                                          child: Container(
                                            width: 186,
                                            height: 36,
                                            child: ImageData(
                                                itemPlacementProvider
                                                    .rug.imagePath,
                                                width: 186,
                                                height: 36),
                                          ),
                                        ),
                                        // Shadow
                                        Positioned(
                                          top:
                                              190, // Adjust position based on the animation value
                                          left: 102,
                                          child: _shadow(),
                                        ),

                                        //// BookShelf
                                        Positioned(
                                          top: 28,
                                          left: 13,
                                          child: Container(
                                              width: 110,
                                              height: 230,
                                              child: ImageData(
                                                  itemPlacementProvider
                                                      .bookshelf.imagePath,
                                                  width: 110,
                                                  height: 230)),
                                        ),
                                        // Character
                                        Positioned(
                                          top: 64 +
                                              _floatingAnimation!
                                                  .value, // Adjust position based on the animation value
                                          left: 102,
                                          child: _buildCharacter(),
                                        ),
                                        //// Clock
                                        Positioned(
                                          left: 165,
                                          top: 0,
                                          child: Container(
                                              width: 64,
                                              height: 64,
                                              child: ImageData(
                                                  itemPlacementProvider
                                                      .clock.imagePath,
                                                  width: 64,
                                                  height: 64)),
                                        ),
                                        //// Window
                                        Positioned(
                                          top: 34,
                                          right: 13,
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            child: ImageData(
                                              itemPlacementProvider
                                                  .window.imagePath,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ),
                                        //// Others
                                        Positioned(
                                          right: 23,
                                          top: 148,
                                          child: Container(
                                            width: 90,
                                            height: 110,
                                            child: ImageData(
                                                itemPlacementProvider
                                                    .others.imagePath,
                                                width: 90,
                                                height: 110),
                                          ),
                                        ),
                                      ],
                                    )));
                          }),
                          stopwatch.status == Status.running
                              ? _stopbutton()
                              : _time(timeProvider.todayTime,
                                  timeProvider.totalTime),
                          const SizedBox(height: 15),
                          Center(child: StopwatchWidget()),
                          Spacer()
                        ],
                      );
                    }),
              )),
        ));
  }
}
