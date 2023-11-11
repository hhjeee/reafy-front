import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/stop_dialog.dart';
import 'package:reafy_front/src/controller/stopwatch_controller.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/utils/timeformat.dart';

class StopWatch extends StatelessWidget {
  final StopWatchController stopwatchController =
      Get.put(StopWatchController());

  void _showStopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StopDialog();
      },
    ).then((result) {
      if (result != null && result is bool && result) {
        // Handle the stop action, e.g., stop the stopwatch
        stopwatchController.toggleSwitch();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stop button pressed')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          /////////////////////////////////////////////////
          GestureDetector(
            onTap: () {
              stopwatchController.toggleSwitch();

              _showStopDialog(context);
              //StopDialog(
              //    totalTime: 123, //totalTime,
              //    dropdownList: ["가", "나", "다"],
              //    selectedBook: "가");
            },
            child: Obx(() {
              return Container(
                width: 338, //stopwatchController.value.value ? 220 : 66,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xfffaf9f7),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 10.0,
                      color: Color.fromRGBO(0, 0, 0, 0.10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      stopwatchController.value.value
                          ? Container(
                              width: 188,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Center(
                                  child: Text(
                                    TimeUtils.formatDuration(stopwatchController
                                        .stopwatchSeconds.value),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 3,
                                      color: green,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Align(
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffd9d9d9),
                          ),
                          child: stopwatchController.value.value
                              ? ImageData(IconsPath.runningbutton, isSvg: false)
                              : ImageData(IconsPath.startbutton, isSvg: false),
                        ),
                      ),
                      ///////////// 재생 시 /////////////
                      stopwatchController.value.value
                          ? Container()
                          : Container(
                              width: 32,
                              /*
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff666666),
                                    ),
                                  ),
                                ),
                              ),*/
                            ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 15),
          //Container(
          //  width: 150,
          //  height: 150,
          //  child: ImageData(IconsPath.state_4, isSvg: false),
          //),
        ],
      ),
    );
  }
}



/*
class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 50),
    vsync: this,
  );

  late final Animation _circleAnimation =
      AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
          .animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear),
  );

  bool value = false;
  int _stopwatchSeconds = 0;
  late Timer _stopwatch;

  void startStopwatch() {
    _stopwatch = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _stopwatchSeconds++;
      });
    });
  }

  void stopStopwatch() {
    _stopwatch.cancel();
  }

  void resetStopwatch() {
    _stopwatch.cancel();
    setState(() {
      _stopwatchSeconds = 0;
    });
  }

  void _showStopDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StopDialog(
          totalTime: _stopwatchSeconds,
          dropdownList: ["가", "나", "다"],
          selectedBook: "가",
        );
      },
    ).then((result) {
      if (result != null && result is bool) {
        if (result) {
          _animationController.reverse();
          stopStopwatch();
        } else {
          _animationController.reverse();
          stopStopwatch();
          resetStopwatch();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('스탑워치가 초기화되었습니다.')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _stopwatch.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int remainingSeconds = duration.inSeconds.remainder(60);
    String timeString = '';
    if (hours > 0) {
      timeString += hours.toString();
      if (hours < 10) {
        timeString = '0$timeString'; // 시간이 1자리일 때 앞에 0을 붙임
      }
      timeString += ':';
    }
    timeString += minutes.toString().padLeft(2, '0'); // 두 자리수로 표시된 분
    timeString += ':';
    timeString += remainingSeconds.toString().padLeft(2, '0'); // 두 자리수로 표시된 초
    return timeString; // 시:분:초 형식으로 반환
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      SizedBox(height: 20),

      /////////////////////////////////////////////////
      AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              setState(() {
                value = !value;
                if (value) {
                  _animationController.reset();
                  _animationController.forward();
                  startStopwatch();
                } else {
                  //_animationController.reverse();
                  //stopStopwatch();

                  _showStopDialog();
                }
              });
            },
            child: Container(
              width: 140,
              height: 46,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1)),
                    BoxShadow(color: white, blurRadius: 15, spreadRadius: 0)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _circleAnimation.value == Alignment.centerRight
                        ? Container(
                            width: 100,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Center(
                                  child: Text(
                                    format(_stopwatchSeconds),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff333333)),
                                  ),
                                )))
                        : Container(),
                    Align(
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffd9d9d9),
                        ),
                        child: _circleAnimation.value == Alignment.centerLeft
                            ? ImageData(IconsPath.startbutton, isSvg: false)
                            : ImageData(IconsPath.runningbutton, isSvg: false),
                      ),
                    ),

                    ///////////// 재생 시 /////////////
                    _circleAnimation.value == Alignment.centerLeft
                        ? Container(
                            width: 92,
                            child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Center(
                                    child: Text('독서 시작하기',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff666666))))))
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      SizedBox(height: 15),
      ////TODO 수정하기
      /*
      _circleAnimation.value == Alignment.centerRight
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (value) {
                        _animationController.reverse();
                        stopStopwatch();
                      }
                    });
                  },
                  child: Text('일시정지'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (value) {
                        _animationController.reverse();
                        stopStopwatch();
                      }
                      resetStopwatch();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('스탑워치가 초기화되었습니다.')));
                    });
                  },
                  child: Text('종료'),
                ),
              ],
            )
          : Container(),
          */

      Container(
        width: 150,
        height: 150,
        child: ImageData(IconsPath.state_4, isSvg: false),
      )
    ]));
  }
}
*/

