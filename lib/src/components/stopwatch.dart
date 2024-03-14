import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';

class StopwatchWidget extends StatelessWidget {
  const StopwatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);
    stopwatch.setTimer(15 * 60); // 시간설정

    void _tapStopwatch(Status status) async {
      switch (status) {
        case Status.paused:
          stopwatch.resume();
          break;

        case Status.running:
          stopwatch.pause();
          break;

        case Status.stopped:
          stopwatch.run();
          break;
      }
    }

    Widget _TextbyStatus(Status status) {
      switch (status) {
        case Status.running:
          return Text(stopwatch.elapsedTimeString,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                  color: green));
        case Status.paused:
          return Text(stopwatch.elapsedTimeString,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                  color: green)); // Replace with your desired text
        case Status.stopped:
        default:
          return Text("독서 시작하기",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: black));
      }
    }
/*
    Widget _displayButton(Status status) {
      return Container(
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
                left:
                    stopwatch.status == Status.running ? 32 : -6, // 위치는 run 여부
                top: -4,
                child: Container(
                    child: Center(
                        child: stopwatch.status == Status.running
                            ? Image.asset('assets/images/runbutton.png',
                                width: 54, height: 54)
                            : stopwatch.status == Status.paused
                                ? Image.asset('assets/images/pausebutton.png',
                                    width: 54, height: 54)
                                : Image.asset('assets/images/stopbutton.png',
                                    width: 54, height: 54))))
          ]));
    }
*/

    Widget _ButtonbyStatus(Status status) {
      switch (status) {
        case Status.running:
          return Image.asset('assets/images/runbutton.png',
              width: 54, height: 54);
        case Status.paused:
          return Image.asset('assets/images/pausebutton.png',
              width: 54, height: 54);
        case Status.stopped:
        default:
          return Image.asset('assets/images/stopbutton.png',
              width: 54, height: 54);
      }
    }

    Widget _displayButton(Status status) {
      double leftPosition = 0;

      switch (status) {
        case Status.running:
          leftPosition = 32;
          break;
        case Status.paused:
        case Status.stopped:
        default:
          leftPosition = -6;
          break;
      }

      return Container(
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
                color: disabled_box, // Replace with actual color
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(
                milliseconds: 300), // Set your desired animation duration
            curve: Curves.easeInOut, // Use the curve you prefer
            left: leftPosition,
            top: -4,
            child: Container(
              child: Center(
                child: _ButtonbyStatus(status),
              ),
            ),
          )
        ]),
      );
    }

    return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
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
                    child: _TextbyStatus(stopwatch.status)),
                GestureDetector(
                    onTap: () {
                      _tapStopwatch(stopwatch.status);
                    },
                    child: _displayButton(stopwatch.status))
              ]),
        ),
      ));
    });
  }
}

/*
class StopwatchProvider extends GetxController {
  var _isRunning = false.obs;
  var _elapsedTime = '00:00:00'.obs;
  var _remainingTime = '10:00'.obs;

  var _itemCnt = 0.obs;
  var _isFull = false.obs;

  bool get isRunning => _isRunning.value;
  String get elapsedTime => _elapsedTime.value;
  String get remainingTime => _remainingTime.value;

  int get itemCnt => _itemCnt.value;
  bool get isFull => _isFull.value;

  void updateIsRunning(bool value) {
    _isRunning.value = value;
    print("_isRunning $_isRunning");
  }

  void updateElapsedTime(String value) {
    _elapsedTime.value = value;
  }

  void incrementItemCount() {
    if (_itemCnt.value < 6) {
      _itemCnt.value += 1;
    }
    if (_itemCnt.value == 6) {
      _isFull.value = true;
    }
  }

  void decreaseItemCount() {
    if (_itemCnt.value > 0) {
      _itemCnt.value -= 1;
      _isFull.value = false;
    }
  }
}*/

/*
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


Widget _character() {
  //late AnimationController _animationController;

  return Container(
    margin: EdgeInsets.only(left: 180.0, top: 20),
    width: 69,
    height: 97, // 적절한 높이 설정
    child: ImageData(IconsPath.character2),
  );
}
*/

/*
class StopWatchWidget extends StatelessWidget {
  final StopwatchProvider stopwatchProvider = Get.find();

  _startStopwatch() {
    stopwatchProvider.updateIsRunning(true);
    stopwatchProvider.incrementItemCount();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!stopwatchProvider.isRunning) {
        timer.cancel();
        return;
      }

      // Update elapsed time every second
      stopwatchProvider.updateElapsedTime(
          _formatTime(stopwatchProvider.itemCnt * 60000 - timer.tick * 1000));
    });
  }

  _stopStopwatch() {
    stopwatchProvider.updateIsRunning(false);
  }

  _resetStopwatch() {
    stopwatchProvider.updateIsRunning(false);
    stopwatchProvider.updateElapsedTime('00:00:00');
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
    return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
      //String _elapsedTime = stopwatch.elapsedTime;
      //bool isrunning = stopwatch.isRunning;

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
                    stopwatch.isRunning ? stopwatch.elapsedTime : "독서 시작하기",
                    style: stopwatch.isRunning
                        ? TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.5,
                            color: green,
                          )
                        : TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (stopwatchProvider.isRunning) {
                      _stopStopwatch();
                    } else {
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
                          left: stopwatchProvider.isRunning ? 32 : -6,
                          top: -4,
                          child: Container(
                            child: Center(
                                child: stopwatchProvider.isRunning
                                    ? Image.asset(
                                        'assets/images/runningbutton.png',
                                        width: 54,
                                        height: 54)
                                    : Image.asset(
                                        'assets/images/startbutton.png',
                                        width: 54,
                                        height: 54)),
                          ))
                    ]),
                  ),
                )
              ]),
        ),
      ));
    });
  }
}*/
/*
class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});
  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  /*
  Stopwatch _stopwatch = Stopwatch();
  //bool isrunning = false;
  Timer? _timer;
  String _elapsedTime = '00:00:00';
  late String _remainingTime;*/

  @override
  void initState() {
    super.initState();
    // Set initial remaining time to 10:00
  }


  void _updateRemainingTime() {
    final remainingMilliseconds = 10000 - _stopwatch.elapsedMilliseconds;
    setState(() {
      _remainingTime = _formatTime(remainingMilliseconds);
    });
  }

  void _startStopwatch() {
    context.read<StopwatchProvider>().updateIsRunning(true);
    _stopwatch.start();
    _updateRemainingTime();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
        // isrunning is already being updated via provider, no need to set it here
      });
    });
  }

  void _stopStopwatch() {
    context.read<StopwatchProvider>().updateIsRunning(false);
    _stopwatch.stop();
    _updateRemainingTime();
    if (_stopwatch.elapsed.inSeconds >= 600) {
      context.read<StopwatchProvider>().incrementItemCount();
    }
    _timer?.cancel();
  }

  void _resetStopwatch() {
    context.read<StopwatchProvider>().updateIsRunning(false);
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00:00';
      _remainingTime = _formatTime(10000);
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
    return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
      //String _elapsedTime = stopwatch.elapsedTime;
      bool isrunning = stopwatch.isRunning;

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
                    stopwatch.isRunning ? _elapsedTime : "독서 시작하기",
                    style: stopwatch.isRunning
                        ? TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.5,
                            color: green,
                          )
                        : TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isrunning) {
                      _stopStopwatch();
                    } else {
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
                                    : Image.asset(
                                        'assets/images/startbutton.png',
                                        width: 54,
                                        height: 54)),
                          ))
                    ]),
                  ),
                )
              ]),
        ),
      ));
    });
  }
}*/
