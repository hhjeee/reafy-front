import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/pages/map.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/repository/timer_repository.dart';
import 'package:reafy_front/src/utils/constants.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Map<String, dynamic>? RemainingTimerData;
  //bool isTimerUpdating = false;

  @override
  initState() {
    super.initState();
    fetchTimerData(); // 서버상 저장된 시간으로 리셋됨
  }

  Future<void> fetchTimerData() async {
    try {
      final data = await getRemainingTime();
      setState(() {
        RemainingTimerData = data;
      });
    } catch (e) {
      print('Error fetching user timer data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    StopwatchProvider stopwatch =
        Provider.of<StopwatchProvider>(context, listen: true);

    int defaultTime = 15 * 60;
    int timer = RemainingTimerData?['timer'] as int? ?? defaultTime;

    if (timer == 0) {
      timer = defaultTime;
    }

    void _tapStopwatch(Status status) async {
      switch (status) {
        case Status.paused:
          stopwatch.resume();
          fetchTimerData();
          break;

        case Status.running:
          stopwatch.pause();
          fetchTimerData();
          break;

        case Status.stopped:
          stopwatch.run();
          fetchTimerData();
          break;
      }
    }

    Widget _TextbyStatus(Status status) {
      switch (status) {
        case Status.running:
          return Text(
              "${stopwatch.elapsedTimeString}", //\t ${stopwatch.lifestatus}",
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
                      if (stopwatch.status == Status.running) {
                        Get.to(() => BambooMap());
                      }
                    },
                    child: _displayButton(stopwatch.status))
              ]),
        ),
      ));
    });
  }
}
