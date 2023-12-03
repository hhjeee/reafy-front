import 'package:flutter/material.dart';
import 'dart:async';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/stop_dialog.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Stopwatch _stopwatch = Stopwatch();
  bool isrunning = false;
  Timer? _timer;
  String _elapsedTime = '00:00:00';

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
        isrunning = true;
      });
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    setState(() {
      isrunning = false;
    });
    _timer?.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();

    setState(() {
      isrunning = false;
      _elapsedTime = '00:00:00';
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      width: 338,
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
              Container(
                width: 200,
                margin: EdgeInsets.only(left: 40.0),
                child: Text(
                  _elapsedTime,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                    color: green,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isrunning) {
                    _stopStopwatch();
                    Navigator.pop(context);
                  } else {
                    Map(context);
                    _startStopwatch();
                  }
                },
                child: Container(
                  width: 78,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Stack(children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: Container(
                          width: 68,
                          height: 26,
                          color: disabled_box,
                        ),
                      ),
                    ),
                    Positioned(
                        left: isrunning ? 32 : -6,
                        top: -4,
                        child: Container(
                          child: Center(
                              child: isrunning
                                  ? Image.asset(
                                      'assets/images/runningbutton.png',
                                      width: 54,
                                      height: 54)
                                  : Image.asset('assets/images/startbutton.png',
                                      width: 54, height: 54)),
                        ))
                  ]),
                ),
              )
            ]),
      ),
    ));
  }
}

void Map(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 720,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 390,
                    height: 720,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconsPath.map),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 390,
                    height: 720,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffffffff),
                          Color.fromRGBO(255, 255, 255, 0.11),
                        ],
                        stops: [0.0, 0.3969],
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, -4.0),
                          blurRadius: 10.0,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.0),
                          _progress(),
                          SizedBox(height: 24.8),
                          _character(),
                          SizedBox(height: 260),
                          //_time2(),
                          Spacer(),
                          _stopbutton(),
                          SizedBox(height: 24.8),
                          Center(
                            child: StopwatchWidget(),
                          ),
                          SizedBox(height: 80),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

Widget _progress() {
  return Container(
    padding: EdgeInsets.only(left: 26.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "대나무 1개 받기까지",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(width: 203.0),
            Text(
              "70%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ), //변경
          ],
        ),
        Container(
          //나중엔 벡터 단위로 받아와서 조건 따라 색 변경해야 할듯
          width: 338.001,
          height: 45.197,
          child: ImageData(IconsPath.bamboo_bar),
        ),
      ],
    ),
  );
}

Widget _stopbutton() {
  return Center(
      child: Container(
          width: 338,
          height: 50,
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
          )));
}

Widget _character() {
  late AnimationController _animationController;

  return Container(
    margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}
