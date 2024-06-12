import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/utils/constants.dart';

class CustomTooltipButton extends StatefulWidget {
  final String message;
  final Color backgroundColor;

  const CustomTooltipButton({
    Key? key,
    required this.message,
    this.backgroundColor = green,
  }) : super(key: key);

  @override
  CustomTooltipButtonState createState() => CustomTooltipButtonState();
}

class CustomTooltipButtonState extends State<CustomTooltipButton> {
  OverlayEntry? _overlayEntry;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    _timer?.cancel();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            left: offset.dx - 135,
            top: offset.dy - size.height - 40,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: hideOverlay, // 툴팁을 탭하면 숨김
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(6, 8, 12, 8),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ImageData(IconsPath.bambooicon,
                              width: 42, height: 42),
                          SizedBox(width: 6),
                          Text(widget.message,
                              style: TextStyle(
                                  color: Color(0xffFAF9F7),
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600)),
                        ],
                      )),
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.only(left: 113),
                      width: 20,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 113, bottom: 0),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Icon(Icons.question_mark_sharp,
                              color: Colors.white, size: 15, weight: 0.5)),
                    ),
                  ]),
                ]),
              ),
            )));

    overlay.insert(_overlayEntry!);
    _starttimer();
  }

  void _starttimer() {
    _timer = Timer(Duration(seconds: 5), () {
      hideOverlay();
    });
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry != null) {
          hideOverlay();
        } else {
          _showOverlay(context);
        }
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: green,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(2, 4), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Icon(Icons.question_mark_sharp,
                color: Colors.white, size: 15, weight: 0.5)),
      ),
    );
  }
}

class TooltipButton extends StatefulWidget {
  const TooltipButton({Key? key}) : super(key: key);

  @override
  TooltipButtonState createState() => TooltipButtonState();
}

class TooltipButtonState extends State<TooltipButton> {
  OverlayEntry? _overlayEntry;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    _timer?.cancel();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    //var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            //right: offset.dx ,
            top: offset.dy + 30,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                  onTap: hideOverlay,
                  child: ImageData(IconsPath.toolkit2,
                      isSvg: false,
                      height: 85,
                      width: 300 //SizeConfig.screenWidth,
                      )),
            )));

    overlay.insert(_overlayEntry!);
    _starttimer();
  }

  void _starttimer() {
    _timer = Timer(Duration(seconds: 5), () {
      hideOverlay();
    });
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (_overlayEntry != null) {
            hideOverlay();
          } else {
            _showOverlay(context);
          }
        },
        child: Container(
            width: SizeConfig.screenWidth - 360,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Icon(Icons.question_mark_sharp,
                          color: black, size: 10)),
                ))));
  }
}
