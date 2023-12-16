import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/pages/book/bookshelf.dart';
import 'package:reafy_front/src/app.dart';

class DoneDialog2 extends StatefulWidget {
  @override
  _DoneDialogState createState() => _DoneDialogState();
}

class _DoneDialogState extends State<DoneDialog2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        //Get.to(() => App());
        /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => App()),
        );*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      //title:
      content: Center(
        child: Container(
            width: 196,
            height: 218,
            child: Lottie.asset(
              'assets/lottie/check.json',
              frameRate: FrameRate.max,
            )),
      ),
    );
  }
}
/////

