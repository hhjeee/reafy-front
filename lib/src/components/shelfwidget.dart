import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/bookdetail.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:reafy_front/src/models/bookcount.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/pages/book/book1.dart';

class BookShelfWidget extends StatefulWidget {
  final String title;
  final List<Book> books;
  final bool isEditMode;

  const BookShelfWidget(
      {required this.title,
      required this.books,
      required this.isEditMode,
      Key? key})
      : super(key: key);

  @override
  State<BookShelfWidget> createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget>
    with TickerProviderStateMixin {
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

  //bool isExpanded = false;

  Set<Book> selectedBooks = {};

  Widget _buildShakeAnimation(Book book, isSelected) {
    return Stack(
      children: [
        RotationTransition(
          turns: _shakeTween.animate(_shakeController),
          child: Container(
            width: 66,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 15.0),
                  blurRadius: 8.0,
                ),
              ],
              border: Border.all(
                color: isSelected ? Color(0xffffd747) : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                book.coverImageUrl,
                fit: BoxFit.fitWidth,
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

  List<Widget> _buildBookList(BuildContext context) {
    //List<Book>  = getMockBooks();
    //final bookModel = context.read<BookModel>();
    //final bookModel = Provider.of<BookModel>(context, listen: false);

    if (!widget.isEditMode) {
      selectedBooks.clear();
    }

    return widget.books.map((book) {
      bool isSelected = selectedBooks.contains(book);
      return Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 7),
        child: GestureDetector(
          onTap: () {
            if (widget.isEditMode) {
              setState(() {
                if (isSelected) {
                  selectedBooks.remove(book);
                } else {
                  selectedBooks.add(book);
                }
              });
              //bookModel.toggleBookSelection(book.title);
            } else {
              Get.to(() => BookDetailPage(book: book));
            }
          },
          child: widget.isEditMode
              ? _buildShakeAnimation(book, isSelected)
              : Container(
                  width: 66,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 15.0),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      book.coverImageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
          //child: BookCover3D(imageUrl: book.coverImageUrl),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return //GestureDetector(
        //onTap: () {
        //Get.to(() = ShelfDetailPage(status: book));
        //},
        //child:
        Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Book1()),
                    );
                  },
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Book1()),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "6", //count
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 7),
                    Container(
                      width: 10,
                      height: 19,
                      child: ImageData(IconsPath.shelf_right, isSvg: true),
                    ),
                    SizedBox(width: 24),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.maxFinite,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/shelf.png'),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      /*ImageData(
                        IconsPath.left,
                        isSvg: true,
                        width: 10,
                      ),*/
                      SizedBox(
                        width: 26.58,
                      ),
                      Row(
                        children: _buildBookList(context),
                      ),
                      SizedBox(
                        width: 25.43,
                      ),
                      /*ImageData(
                        IconsPath.right,
                        width: 10,
                        isSvg: true,
                      ),*/
                    ])),
              ],
            ),
          ),
          SizedBox(height: 15),
        ]));
  }
}
