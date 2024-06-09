import 'dart:async';
import 'dart:ui';

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

    overlay?.insert(_overlayEntry!);
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
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            right: offset.dx + 20,
            top: offset.dy + 20,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                  onTap: hideOverlay, // 툴팁을 탭하면 숨김
                  child: ImageData(
                    IconsPath.toolkit2,
                    isSvg: false,
                    height: 72,
                    width: 247,
                  )),
            )));

    overlay?.insert(_overlayEntry!);
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: green,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: Icon(Icons.question_mark_sharp,
                  color: Colors.white, size: 10, weight: 0.5)),
        ));
    // ImageData(
    //   IconsPath.toolkit,
    //   isSvg: true,
    //   width: 12,
    //   height: 12,
    // ));
  }
}
