import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/dialog/done.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';

class DeleteDialog extends StatefulWidget {
  final Function onConfirmDelete;

  const DeleteDialog({Key? key, required this.onConfirmDelete})
      : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
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
        height: 180,
        child: Column(children: [
          SizedBox(height: 40.0),
          Consumer<SelectedBooksProvider>(
            builder: (context, selectedBooksProvider, _) {
              return Text(
                "총 ${selectedBooksProvider.selectedBooks.length}권을 정말 삭제하시겠어요? \n 등록한 책이 사라져요!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  selectedBooksProvider.clearBooks();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffebebeb),
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
                onPressed: () async {
                  try {
                    List<int> bookshelfBookIds = selectedBooksProvider
                        .selectedBooks
                        .map((book) => book.bookshelfBookId)
                        .toList();

                    for (int bookshelfBookId in bookshelfBookIds) {
                      await deleteBookshelfBook(bookshelfBookId);
                    }
                    selectedBooksProvider.clearBooks();
                    Provider.of<BookShelfProvider>(context, listen: false)
                        .fetchData();

                    Navigator.pop(context);
                    widget.onConfirmDelete();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DoneDialog(onDone: () {});
                      },
                    );
                  } catch (e) {
                    print("$e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffffd747),
                  minimumSize: Size(140, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '확인',
                  style: const TextStyle(
                    color: Color(0xff000000),
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
