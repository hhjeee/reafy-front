import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';

class StopDialog extends StatefulWidget {
  @override
  _StopDialogState createState() => _StopDialogState();
}

class _StopDialogState extends State<StopDialog> {
  final List<String> dropdownList = ['미드나잇 라이브러리', '별들이 겹치는 순간', '너 없는 동안'];
  String selectedBook = '별들이 겹치는 순간';

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  bool isButtonEnabled = false;
  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          textController1.text.isNotEmpty && textController2.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    StopwatchProvider stopwatch = Provider.of<StopwatchProvider>(context);

    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SingleChildScrollView(
            child: Container(
          width: 320,
          height: 459,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                stopwatch.elapsedTimeString,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 14.0),
              const Text(
                "독서 내용을 기록해주세요!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageData(
                    IconsPath.bamboo,
                    isSvg: true,
                  ),
                  const Text(
                    "15개", //나중에 죽순 계산하도록 수정
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "읽은 책:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 266,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1.0,
                            blurRadius: 7.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          value: selectedBook,
                          //icon: ImageData(IconsPath.dropdown),
                          items: dropdownList.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0), // 내부 패딩 설정
                                child: Text(item),
                              ),
                              //child: Text(item),
                            );
                          }).toList(),
                          onChanged: (dynamic item) {
                            setState(() {
                              selectedBook = item;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "읽은 페이지:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 130, //TextField 크기
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1.0,
                                blurRadius: 7.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '시작',
                                  style: TextStyle(
                                      color: Color(0xff666666), fontSize: 13),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: textController1,
                                  onChanged: (_) {
                                    updateButtonState();
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'p',
                                  style: TextStyle(
                                      color: textController1.text.isNotEmpty
                                          ? Color(0xff333333)
                                          : Color(0xff666666),
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 130, //TextField 크기
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1.0,
                                blurRadius: 7.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '끝',
                                  style: TextStyle(
                                      color: Color(0xff666666), fontSize: 13),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: textController2,
                                  onChanged: (_) {
                                    updateButtonState();
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'p',
                                  style: TextStyle(
                                      color: textController2.text.isNotEmpty
                                          ? Color(0xff333333)
                                          : Color(0xff666666),
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            ////// 서버에 보내고 시간 업데이트
                            ////// 스탑워치 멈추기, 초기화
                            ///
                            //stopwatch.stop();
                            context.read<StopwatchProvider>().stop();
                            context
                                .read<StopwatchProvider>()
                                .updateElapsedTime('00:00:00');
                            Get.back();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: isButtonEnabled
                          ? Color(0xffffd747)
                          : Color(0xffebebeb),
                      minimumSize: Size(286, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      '독서 완료하기',
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StopwatchProvider>().resume();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffffffff),
                      minimumSize: Size(286, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      '계속 읽기',
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
