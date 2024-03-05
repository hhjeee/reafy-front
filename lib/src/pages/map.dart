import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/coin_provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/repository/coin_repository.dart';

class BambooState {
  bool isVisible;
  //bool isActive;
  Offset position;
  BambooState(this.isVisible, this.position);
}

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});
  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late List<AnimationController> _bambooController;
  late List<Animation<double>> _bambooAnimation;
  late StopwatchProvider stopwatch;

  int? userCoin;

  List<BambooState> bambooStates =
      List.generate(6, (index) => BambooState(false, Offset(0, 0)));

  List<Offset> bambooPositions = [
    Offset(135, 192),
    Offset(68, 256),
    Offset(266, 269),
    Offset(292, 162),
    Offset(206, 126),
    Offset(15, 138),
  ];

  @override
  void initState() {
    super.initState();
    stopwatch = StopwatchProvider();
    WidgetsBinding.instance.addObserver(stopwatch);

    _bambooController = List.generate(
        6,
        (index) => AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 1600),
            )..repeat(reverse: true));

    _bambooAnimation = _bambooController
        .map((controller) => Tween<double>(begin: 0.95, end: 1.08).animate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.easeInOut,
              ),
            ))
        .toList();
    loadUserCoin();
    Future.microtask(
        () => Provider.of<CoinProvider>(context, listen: false).updateCoins());
  }

  @override
  void dispose() {
    for (var controller in _bambooController) {
      controller.dispose();
    }
    WidgetsBinding.instance.removeObserver(stopwatch);
    stopwatch.dispose();
    super.dispose();
  }

/*  void regenerateBamboo() {
    for (int i = 0; i < bambooStates.length; i++) {
      if (!bambooStates[i].isActive) {
        setState(() {
          bambooStates[i].isActive = true;
        });
        break;
      }
    }
}*/

  Future<void> loadUserCoin() async {
    try {
      int? coin = await getUserCoin();
      setState(() {
        userCoin = coin ?? 0;
      });
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  Widget bamboo_collect(BuildContext context) {
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);

    for (int i = 0; i < bambooStates.length; i++) {
      bambooStates[i] = BambooState(i < stopwatch.itemCnt, bambooPositions[i]);
    }

    return Stack(
      children: List.generate(6, (index) {
        BambooState state = bambooStates[index];

        return AnimatedPositioned(
            duration: Duration(milliseconds: 3000),
            curve: Curves.elasticIn,
            left: state.position.dx,
            bottom: state.position.dy,
            child: AnimatedBuilder(
              animation: _bambooAnimation[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: _bambooAnimation[index].value,
                  child: child,
                );
              },
              child: AnimatedScale(
                scale: state.isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 2000),
                curve: Curves.elasticOut,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      state.isVisible = false;
                      //bambooStates[index].isActive = false;
                    });
                    stopwatch.decreaseItemCount();
                    try {
                      await updateCoin(1, true);
                      int currentCoin =
                          Provider.of<CoinProvider>(context, listen: false)
                              .coins;
                      Provider.of<CoinProvider>(context, listen: false)
                          .setCoins(currentCoin + 1);
                    } catch (e) {
                      print('에러 발생: $e');
                    }

                    Future.delayed(Duration(seconds: 2), () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BambooDialog(userCoin: userCoin);
                          });
                    });
                  },
                  child: ImageData(IconsPath.bambooicon, width: 90, height: 90),
                ),
              ),
            ));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    //bool isNight = _isNightTime();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconsPath.bamboomap), fit: BoxFit.cover),
          ),
        ),
        BubbleWidget(),
        Positioned(
          bottom: 0,
          child: Container(
              width: size.width, height: 500, child: bamboo_collect(context)),
        ),
        BottomBarWidget(userCoin: userCoin)
      ],
    ));
  }
}

class BubbleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 221,
      left: 176,
      child: GestureDetector(
        onTap: () {
          //Get.to(Board());
        },
        child: Stack(
          children: [
            ImageData(
              IconsPath.map_bubble,
              width: 112,
              height: 77,
              isSvg: true,
            ),
            Container(
              width: 112,
              height: 63,
              child: Consumer<StopwatchProvider>(
                builder: (context, stopwatch, child) {
                  return BambooBubbleContent(stopwatch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BambooBubbleContent extends StatelessWidget {
  final StopwatchProvider stopwatch;

  BambooBubbleContent(this.stopwatch);

  @override
  Widget build(BuildContext context) {
    if (stopwatch.itemCnt >= 6) {
      return Center(
        child: Text(
          "꼬르륵~",
          style: TextStyle(
            color: black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else if (stopwatch.status == Status.running && !stopwatch.isFull) {
      return BambooBubbleRunningContent(stopwatch);
    } else {
      return Center(
        child: Text(
          "쉬고 있어요 :)",
          style: TextStyle(
            color: black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }
}

class BambooBubbleRunningContent extends StatelessWidget {
  final StopwatchProvider stopwatch;

  BambooBubbleRunningContent(this.stopwatch);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "다음 대나무까지",
          style: TextStyle(
            color: black,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 3),
        Text(
          stopwatch.remainTimeString,
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class BottomBarWidget extends StatelessWidget {
  final int? userCoin;

  BottomBarWidget({Key? key, required this.userCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 51,
      left: 34,
      child: Row(children: [
        SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: green,
            child: ImageData(
              IconsPath.back_arrow,
              //width: 44,
              //height: 44,
              isSvg: true,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 245,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 54, vertical: 14),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "내가 가진 대나무",
                style: TextStyle(
                  color: dark_gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                Provider.of<CoinProvider>(context).coins.toString(),
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class BambooDialog extends StatelessWidget {
  final int? userCoin;

  BambooDialog({Key? key, required this.userCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 228,
          height: 223,
          padding: EdgeInsets.fromLTRB(17, 30, 17, 17),
          child: Column(children: [
            //SizedBox(height: 30.0),
            Text(
              "냠~ 대나무를 주웠어요",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              "현재 대나무 수",
              //poobaoHome.selectedItemName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageData(
                  IconsPath.bamboo,
                  isSvg: true,
                  width: 44,
                ),
                Text(
                  Provider.of<CoinProvider>(context).coins.toString(),
                  style: TextStyle(
                    color: Color(0xff808080),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffffd747),
                minimumSize: Size(140, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                '확인',
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
        ));
  }
}
