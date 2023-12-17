import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';

class DoneDialog extends StatefulWidget {
  final Function onDone;
  DoneDialog({required this.onDone});

  @override
  _DoneDialogState createState() => _DoneDialogState();
}

class _DoneDialogState extends State<DoneDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        widget.onDone();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196,
      height: 218,
      padding: EdgeInsets.zero,
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Lottie.asset('assets/lottie/check.json',
              frameRate: FrameRate.max, width: 100)),
    );
  }
}
