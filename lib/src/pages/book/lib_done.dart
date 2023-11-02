import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.6;
    final width = MediaQuery.of(context).size.width * 0.75;
    return Container(
        child: Center(
            child: Container(
      height: height,
      width: width,
      color: Colors.blueAccent,
      child: Text("완독"),
    )));
  }
}
