import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:provider/provider.dart';

class AddDialog extends StatefulWidget {
  final String isbn13;

  AddDialog({required this.isbn13});

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late String isbn13;
  int progressState = 1;
  bool isLoading = false;
  bool showCheckAnimation = false;

  Future<void> onConfirmPressed() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      // post 성공시 DoneDialog
      bool apiSuccess = await postBookInfo(isbn13, progressState);

      if (apiSuccess) {
        Provider.of<BookShelfProvider>(context, listen: false).fetchData();
        Navigator.pop(context); // DeleteDialog 닫기

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DoneDialog(onDone: () {
              BottomNavController.to.goToBookShelf();
              Navigator.pop(context);
            });
          },
        );
      } else {
        print("POST 성공, 하지만 서버로부터 응답이 예상과 다릅니다.");
      }
    } catch (e) {
      print("POST 실패: $e");
    } /*finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }*/
  }

  @override
  void initState() {
    super.initState();
    isbn13 = widget.isbn13;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      //title:
      content: Container(
        width: 320,
        height: 185,
        child: Column(children: [
          SizedBox(height: 40.0),
          Text(
            "어디에 등록하시겠습니까?",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BookStatusButtonGroup(
                onStatusSelected: (selectedButtonIndex) {
                  setState(() {
                    progressState = selectedButtonIndex == 0 ? 1 : 2;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffEBEBEB),
                minimumSize: Size(140, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                '취소',
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 6),
            ElevatedButton(
              onPressed: isLoading ? null : onConfirmPressed,
              style: ElevatedButton.styleFrom(
                primary: Color(0xffffd747),
                minimumSize: Size(140, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? CircularProgressIndicator(color: yellow)
                  : Text(
                      '확인',
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ])
        ]),
      ),
      actions: <Widget>[],
    );
  }
}

/////

class BookStatusButtonGroup extends StatefulWidget {
  final Function(int) onStatusSelected;

  BookStatusButtonGroup({required this.onStatusSelected});

  @override
  _BookStatusButtonGroupState createState() => _BookStatusButtonGroupState();
}

class _BookStatusButtonGroupState extends State<BookStatusButtonGroup> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 266,
          height: 30,
          decoration: BoxDecoration(
            color: bg_gray,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BookStatusButton(
              status: '읽고 있는 책',
              isSelected: selectedButtonIndex == 0,
              onPressed: () {
                setState(() {
                  selectedButtonIndex = 0;
                  widget.onStatusSelected(selectedButtonIndex);
                });
              },
            ),
            BookStatusButton(
              status: '완독한 책',
              isSelected: selectedButtonIndex == 1,
              onPressed: () {
                setState(() {
                  selectedButtonIndex = 1;
                  widget.onStatusSelected(selectedButtonIndex);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

class BookStatusButton extends StatelessWidget {
  final String status;
  final bool isSelected;
  final VoidCallback onPressed;

  const BookStatusButton({
    required this.status,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: 133,
        height: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: isSelected ? yellow_light : bg_gray,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      )
    ]);
  }
}
