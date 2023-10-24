
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/stop_dialog.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

//import 'package:readit/src/pages/timer/custom_switch.dart';

//
class StopWatch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const StopWatch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  int initialTime = 0;
  bool isRunning = false;
  bool startRunning = false;
  late Timer timer;

  Animation? _circleAnimation;
  AnimationController? _animationController;

  void onTick(Timer timer) {
    //타이머 바뀔때마다 실행할 함수
    setState(() {
      initialTime = initialTime + 1;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1), ////60초마다 실행
      onTick,
    );
    setState(() {
      isRunning = true;
    });
    setState(() {
      startRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
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
        timeString = '$timeString'; // 시간이 1자리일 때 앞에 0을 붙임
      }
      timeString += ':';
    }
    timeString += minutes.toString().padLeft(2, '0'); // 두 자리수로 표시된 분
    timeString += ':';
    timeString += remainingSeconds.toString().padLeft(2, '0'); // 두 자리수로 표시된 초
    return timeString; // 시:분:초 형식으로 반환
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownList = ['가', '나', '다'];
    String selectedBook = '가';

    return Container(
      //margin: EdgeInsets.only(top: 123.0),
      child: Column(
        children: [
          Text(
            isRunning ? '집중모드' : '독서 시작하기', // 아이콘 아래에 표시될 텍스트
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          ///////// 스탑워치 /////////
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  if (_animationController!.isCompleted) {
                    _animationController!.reverse();
                  } else {
                    _animationController!.forward();
                  }
                  widget.value == false
                      ? widget.onChanged(true)
                      : widget.onChanged(false);

                  if (!widget.value) {
                    widget.onChanged(true); // value를 true로 변경하고 onChanged 콜백 호출
                  }

                  if (widget.value) {
                    setState(() {
                      isRunning = true;
                    });
                  }
                },
                child: Container(
                  width: 130,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: _circleAnimation!.value == Alignment.centerLeft
                          ? Color(0xffEBEBEB)
                          : Color(0xff63B865)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
                    child: Container(
                      alignment: widget.value
                          ? ((Directionality.of(context) == TextDirection.rtl)
                              ? Alignment.centerRight
                              : Alignment.centerLeft)
                          : ((Directionality.of(context) == TextDirection.rtl)
                              ? Alignment.centerLeft
                              : Alignment.centerRight),
                      child: Stack(alignment: Alignment.center, children: [
                        Text(
                          isRunning ? format(initialTime) : '',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        Container(
                          //alignment: _circleAnimation!.value, // 여기서 _circleAnimation의 값 적용
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: SvgPicture.asset('assets/svg/face.svg',
                                width: 10,
                                height: 10,
                                color: Color(0xff000000)),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          //////////// 버튼 /////////////
          Container(
              alignment: Alignment.center,
              //width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 아이템을 수평으로 가운데 정렬
                children: [
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          //iconSize: 40,
                          onPressed:
                              isRunning ? onPausePressed : onStartPressed,
                          icon: isRunning
                              ? ImageData(IconsPath.pause, isSvg: true)
                              : ImageData(IconsPath.play, isSvg: false),
                          color: Color(0xffcccccc),
                        ),
                        //SizedBox(height: 2), // 아이콘과 텍스트 사이의 간격
                        Text(
                          isRunning ? '일시정지' : '시작', // 아이콘 아래에 표시될 텍스트
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          //iconSize: 40,
                          onPressed: () {
                            onPausePressed();
                            //StopDialog(
                            //  totalTime: format(initialTime),
                            //  dropdownList: dropdownList,
                            //  selectedBook: selectedBook,
                            //);
                          },
                          icon: ImageData(
                            IconsPath.stop,
                            isSvg: true,
                          ),
                          color: Color(0xffcccccc),
                        ),
                        //SizedBox(height: 2), // 아이콘과 텍스트 사이의 간격
                        Text(
                          '중단',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

/*Flexible(
                child: IconButton(
                  padding: EdgeInsets.only(right: 34.0),
                  alignment: Alignment.center,
                  iconSize: 30,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                  color: Color(0xffcccccc),
                ),
              ),

              Flexible(
                child: IconButton(
                  padding: EdgeInsets.only(left: 34.0),
                  alignment: Alignment.center,
                  iconSize: 30,
                  onPressed: () {
                    onPausePressed();
                    FlutterDialog();
                  },
                  icon: Icon(Icons.stop),
                  color: Color(0xffcccccc),
                ),
              ),
              
              
              
              
              
              
              
              
              
           
                            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],   */
