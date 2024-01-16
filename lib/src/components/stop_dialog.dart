import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/provider/stopwatch_provider.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/repository/history_repository.dart';

class StopDialog extends StatefulWidget {
  @override
  _StopDialogState createState() => _StopDialogState();
}

class _StopDialogState extends State<StopDialog> {
  List<ReadingBookInfo> books = [];
  int? selectedBookId;

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
  void initState() {
    super.initState();
    fetchReadingBooksInfo(1).then((fetchedBooks) {
      setState(() {
        books = fetchedBooks;
        if (books.isNotEmpty) {
          selectedBookId = books[0].bookshelfBookId;
        }
      });
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
          height: 420,
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
              /*Row(
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
              ),*/
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
                      padding: EdgeInsets.all(2.0),
                      width: 266,
                      height: 42,
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
                      child: DropdownButton<int>(
                          isExpanded: true,
                          underline: Container(),
                          value: selectedBookId,
                          //icon: ImageData(IconsPath.dropdown),
                          items: books.map((ReadingBookInfo book) {
                            return DropdownMenuItem<int>(
                              value: book.bookshelfBookId,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(book.title),
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedBookId = newValue;
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
                        ? () async {
                            int readingTime = parseTimeStringToMinutes(
                                stopwatch.elapsedTimeString);
                            int? startPage = int.tryParse(textController1.text);
                            int? endPage = int.tryParse(textController2.text);

                            CreateUserBookHistoryDto historyDto =
                                CreateUserBookHistoryDto(
                              bookshelfBookId: selectedBookId,
                              startPage: startPage,
                              endPage: endPage,
                              duration: readingTime,
                              coins: 0,
                            );
                            await createUserBookHistory(historyDto);

                            context.read<StopwatchProvider>().stop();
                            context
                                .read<StopwatchProvider>()
                                .updateElapsedTime('00:00:00');
                            Get.back();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DoneDialog(onDone: () {});
                              },
                            );
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

int parseTimeStringToMinutes(String timeString) {
  List<String> parts = timeString.split(':');
  if (parts.length != 3) {
    return 0;
  }
  int hours = int.tryParse(parts[0]) ?? 0;
  int minutes = int.tryParse(parts[1]) ?? 0;
  int seconds = int.tryParse(parts[2]) ?? 0;

  int totalSeconds = hours * 3600 + minutes * 60 + seconds;
  // 분 단위로 변환하고 남은 초가 30초 이상이면 반올림
  return (totalSeconds / 60).round();
}
