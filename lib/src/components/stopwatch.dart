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
    // StopwatchProvider stopwatch =
    //     Provider.of<StopwatchProvider>(context, listen: true);

    int defaultTime = 15 * 60;
    int timer = RemainingTimerData?['timer'] as int? ?? defaultTime;

    if (timer == 0) {
      timer = defaultTime;
    }

    Widget _TextbyStatus(Status status) {
      return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
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
      });
    }

    Widget _ButtonbyStatus(Status status, Size size) {
      switch (status) {
        case Status.running:
          return Image.asset('assets/images/runbutton.png',
              width: size.width * 0.13, height: size.width * 0.13);
        case Status.paused:
          return Image.asset('assets/images/pausebutton.png',
              width: size.width * 0.13, height: size.width * 0.13);
        case Status.stopped:
        default:
          return Image.asset('assets/images/stopbutton.png',
              width: size.width * 0.13, height: size.width * 0.13);
      }
    }

    Widget _displayButton(Status status, Size size) {
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
        width: size.width * 0.2,
        height: size.height * 0.06,
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Stack(children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Container(
                width: 68,
                height: size.height * 0.03,
                color: disabled_box, // Replace with actual color
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(
                milliseconds: 300), // Set your desired animation duration
            curve: Curves.easeInOut, // Use the curve you prefer
            left: leftPosition,
            top: -5,
            child: Container(
              child: Center(
                child: _ButtonbyStatus(status, size),
              ),
            ),
          )
        ]),
      );
    }

    return Consumer<StopwatchProvider>(builder: (context, stopwatch, child) {
      final size = MediaQuery.of(context).size;
      return Container(
          child: Container(
        width: size.width * 0.87,
        height: size.height * 0.06,
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
                    width: size.width * 0.5,
                    margin: EdgeInsets.only(left: 40.0),
                    child: _TextbyStatus(stopwatch.status)),
                GestureDetector(
                    onTap: () {
                      stopwatch.tapStopwatch(stopwatch.status);
                      if (stopwatch.status == Status.running) {
                        Get.to(() => BambooMap());
                      }
                    },
                    child: _displayButton(stopwatch.status, size))
              ]),
        ),
      ));
    });
  }
}
