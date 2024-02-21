import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';

class ModifyDialog extends StatefulWidget {
  final int bookId;
  ModifyDialog({required this.bookId});
  @override
  _ModifyDialogState createState() => _ModifyDialogState();
}

class _ModifyDialogState extends State<ModifyDialog> {
  late String isbn13;
  int? progressState;

  bool isLoading = false;
  bool showCheckAnimation = false;

  @override
  void initState() {
    super.initState();
    initializeProgressState();
  }

  void initializeProgressState() async {
    try {
      final bookshelfBookDetails = await getBookshelfBookDetails(widget.bookId);
      if (mounted) {
        setState(() {
          progressState = bookshelfBookDetails.progressState;
        });
      }
    } catch (e) {
      print("Error fetching book details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SelectedBooksProvider selectedBooksProvider =
        Provider.of<SelectedBooksProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 320,
        height: 200,
        child: Column(children: [
          SizedBox(height: 40.0),
          Text(
            "상태를 변경해 주세요!",
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          progressState != null
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  BookStatusButtonGroup(
                    initialSelectedIndex: progressState!,
                    onStatusSelected: (selectedButtonIndex) {
                      setState(() {
                        progressState = selectedButtonIndex;
                      });
                    },
                  )
                ])
              : CircularProgressIndicator(),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffebebeb),
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
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await updateBookshelfBookCategory(
                        widget.bookId, progressState!);
                    selectedBooksProvider.clearBooks();
                    Navigator.pop(context); // DeleteDialog 닫기
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DoneDialog(onDone: () {
                          BottomNavController.to.goToBookShelf();
                          Navigator.pop(context);
                        });
                      },
                    );
                  } catch (e) {
                    // 오류 처리
                    print("Error updating bookshelf book category: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffd747),
                  minimumSize: Size(140, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '확인',
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      actions: <Widget>[],
    );
  }
}

/////

class BookStatusButtonGroup extends StatefulWidget {
  final int initialSelectedIndex;
  final Function(int) onStatusSelected;

  BookStatusButtonGroup(
      {required this.initialSelectedIndex, required this.onStatusSelected});

  @override
  _BookStatusButtonGroupState createState() => _BookStatusButtonGroupState();
}

class _BookStatusButtonGroupState extends State<BookStatusButtonGroup> {
  late int selectedButtonIndex;

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = widget.initialSelectedIndex;
  }

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
              isSelected: selectedButtonIndex == 1,
              onPressed: () {
                setState(() {
                  selectedButtonIndex = 1;
                  widget.onStatusSelected(selectedButtonIndex);
                });
              },
            ),
            BookStatusButton(
              status: '완독한 책',
              isSelected: selectedButtonIndex == 2,
              onPressed: () {
                setState(() {
                  selectedButtonIndex = 2;
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
