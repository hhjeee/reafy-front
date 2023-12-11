/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/bookdetail.dart';
import 'package:reafy_front/src/pages/book/category_bookshelf.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/models/bookcount.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/pages/book/category_bookshelf.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/provider/selectedbooks_provider.dart';

class Category_BookShelfWidget extends StatefulWidget {
  final List<BookshelfBookInfo> books;
  final bool isEditMode;

  const Category_BookShelfWidget(
      {required this.books, required this.isEditMode, Key? key})
      : super(key: key);

  @override
  State<Category_BookShelfWidget> createState() =>
      State_Category_BookShelfWidgetState();
}

class State_Category_BookShelfWidgetState
    extends State<Category_BookShelfWidget> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Tween<double> _shakeTween = Tween<double>(begin: -0.005, end: 0.005);

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _shakeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  //Set<BookshelfBookInfo> selectedBooks = {};

  Widget _buildShakeAnimation(BookshelfBookInfo book, isSelected) {
    return Stack(
      children: [
        RotationTransition(
          turns: _shakeTween.animate(_shakeController),
          child: Container(
            width: 94,
            height: 127,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Color(0xffffffff),
              border: Border.all(
                color: isSelected ? Color(0xffffd747) : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                book.thumbnailURL,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  // 이미지를 불러오는 데 실패한 경우의 처리
                  return const Text('이미지를 불러올 수 없습니다.');
                },
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(0xffffd747).withOpacity(0.5) //0.7
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SelectedBooksProvider(),
        child: Consumer<SelectedBooksProvider>(
            builder: (context, selectedBooksProvider, child) {
          return Container(
              margin: EdgeInsets.only(top: 22),
              child: SingleChildScrollView(
                  child: Container(
                height: 650,
                child: GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 한 행에 표시할 아이템 수
                    crossAxisSpacing: 28.0, // 아이템 간 가로 간격
                    mainAxisSpacing: 30.0, // 아이템 간 세로 간격
                    childAspectRatio: 0.6,
                  ),
                  itemCount: widget.books.length,
                  itemBuilder: (context, index) {
                    final book = widget.books[index];
                    bool isSelected =
                        selectedBooksProvider.selectedBooks.contains(book);

                    return GestureDetector(
                      onTap: () {
                        if (widget.isEditMode) {
                          setState(() {
                            if (isSelected) {
                              selectedBooksProvider.removeBook(book);
                            } else {
                              selectedBooksProvider.addBook(book);
                              print(selectedBooksProvider.selectedBooks);
                            }
                          });
                        } else {
                          //Get.to(() => BookDetailPage(book: book));
                        }
                      },
                      child: Column(
                        children: [
                          widget.isEditMode
                              ? _buildShakeAnimation(book, isSelected)
                              : Container(
                                  width: 94,
                                  height: 127,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: Color(0xffffffff),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      book.thumbnailURL,
                                      fit: BoxFit.fitWidth,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Text('이미지를 불러올 수 없습니다.');
                                      },
                                    ),
                                  ),
                                ),
                          SizedBox(height: 5),
                          Text(
                            book.title.length > 8
                                ? '${book.title.substring(0, 8)}...'
                                : book.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )));
        }));
  }
}
*/