import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';

class BambooState {
  bool isVisible;
  Offset position;
  BambooState(this.isVisible, this.position);
}

class BambooMap extends StatefulWidget {
  const BambooMap({super.key});
  @override
  State<BambooMap> createState() => _BambooMapState();
}

class _BambooMapState extends State<BambooMap> with TickerProviderStateMixin {
  late List<AnimationController> _bambooController;
  late List<Animation<double>> _bambooAnimation;
  List<BambooState> bambooStates =
      List.generate(6, (index) => BambooState(false, Offset(0, 0)));

/*
  @override
  void initState() {
    super.initState();
    _bambooController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _bambooAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _bambooController,
        curve: Curves.easeOut,
      ),
    );

    for (int i = 0; i < stopwatch.itemCnt; i++) {
      bambooStates[i].isVisible = true;
    }
  }*/
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
  }

  @override
  void dispose() {
    for (var controller in _bambooController) {
      controller.dispose();
    }
    super.dispose();
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
                  onTap: () {
                    setState(() {
                      state.isVisible = false;
                      stopwatch.decreaseItemCount();
                    });

                    //_bambooController.forward();
                    Future.delayed(Duration(seconds: 1), () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _dialog(context);
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
        _bubble(),
        Positioned(
          bottom: 0,
          //left: 38,
          child: Container(
              width: size.width, height: 500, child: bamboo_collect(context)),
        ),
        _bottombar(),
      ],
    ));
  }
}

Widget _bubble() {
  return Positioned(
      top: 221,
      left: 176,
      child: GestureDetector(
          onTap: () {
            //Get.to(Board());
          },
          child: Stack(children: [
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
                  if (stopwatch.isFull) {
                    return Container(
                        child: Center(
                            child: Text(
                      "꼬르륵~",
                      //"대나무가 다 자랐어요!\n주워볼까요?",
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )));
                  } else if ((stopwatch.status == Status.running) &&
                      !stopwatch.isFull) {
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
                          const SizedBox(height: 3),
                          Text(
                            stopwatch.remainTimeString,
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          )
                        ]);
                  } else {
                    return Container(
                        child: Center(
                            child: Text(
                      "쉬고 있어요 :)", //쉬고 있어요 :)",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )));
                  }
                }))
          ])));
}

Widget _character() {
  return Container(
    //margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}

Widget _bottombar() {
  return Positioned(
    bottom: 51, // Adjust the value as needed
    left: 34,
    child: Row(
      children: [
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
                "15개",
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        /*
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            icon: ImageData(
              IconsPath.back_arrow,
              width: 44,
              height: 44,
              isSvg: true,
            ),
            onPressed: () {
              Get.back();
            },
            color: Colors.white,
          ),
        ),*/
      ],
    ),
  );
}

Widget _dialog(context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    contentPadding: EdgeInsets.zero,
    content: Container(
      width: 228,
      height: 213,
      padding: EdgeInsets.fromLTRB(17, 30, 17, 17),
      child: Column(children: [
        //SizedBox(height: 30.0),
        Text(
          "냠~ 대나무를 주웠어요!",
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
            const Text(
              "53개", //나중에 죽순 계산하도록 수정
              style: TextStyle(
                color: Color(0xff808080),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        ElevatedButton(
          onPressed: () {
            /// TODO 증가 요청
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xffffd747),
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
    ),
  );
}
