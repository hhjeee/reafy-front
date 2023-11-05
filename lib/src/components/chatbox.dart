import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  List<String> messages = [
    "반가워요! 오늘도 같이 책읽을까요?",
    "요즘은 “별들이 겹치는 순간”을 \n읽고있어요 :)",
  ];

  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftBottom,
    nipWidth: 5,
    nipHeight: 18,
    color: Color(0xffFCFCFA),
    radius: Radius.circular(12.0),
    borderWidth: 0,
    elevation: 0,
    margin: BubbleEdges.only(top: 20),
    padding: BubbleEdges.symmetric(vertical: 12, horizontal: 20),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightBottom,
    nipWidth: 5,
    nipHeight: 18,
    color: Color(0xffFCFCFA),
    radius: Radius.circular(12.0),
    borderWidth: 0,
    elevation: 0,
    margin: BubbleEdges.only(top: 20),
    padding: BubbleEdges.symmetric(vertical: 12, horizontal: 20),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      //height: 250,
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return _buildChatBubble(messages[index], true);
        },
      ),
    );
  }

  Widget _buildChatBubble(String message, bool right) {
    return Bubble(
        style: right ? styleSomebody : styleMe,
        child: Text(
          message,
          style: TextStyle(
            color: Color(0xff333333),
          ),
        ));
    /*
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xffFCFCFA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );*/
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        messages.add("이 책은 정말 재미있어요!");
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        messages.add("어떤 책을 읽을지 고민 중이에요.");
      });
    });
  }
}
