import 'package:flutter/material.dart';

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("읽는 중"),
    ));
  }
}
