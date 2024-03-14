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
  _CustomTooltipButtonState createState() => _CustomTooltipButtonState();
}

class _CustomTooltipButtonState extends State<CustomTooltipButton> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
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
            onTap: _hideOverlay, // 툴팁을 탭하면 숨김
            child: Container(
                padding: EdgeInsets.fromLTRB(6, 6, 12, 8),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.bambooicon, width: 42, height: 42),
                    SizedBox(width: 6),
                    Text(widget.message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
          ),
        ),
      ),
    );

    overlay?.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry != null) {
          _hideOverlay();
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
