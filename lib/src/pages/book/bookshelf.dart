import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/shelfwidget.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/addbook.dart';
import 'package:reafy_front/src/components/delete_book2.dart';
import 'package:reafy_front/src/repository/bookshelf_repository.dart';
import 'package:reafy_front/src/components/state_BookList.dart';
import 'package:reafy_front/src/provider/state_book_provider.dart';
import 'package:provider/provider.dart';

class BookShelf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookShelfState();
  }
}

class _BookShelfState extends State<BookShelf> {
  //List<Book> recentBooks = getrecentBooks();
  //List<Book> wishlistBooks = getwishlistBooks();
  List<Book> finishedBooks = getfinishedBooks();

  bool isEditMode = false;

  List<String> thumbnailsForProgressState1 = [];
  List<String> thumbnailsForProgressState2 = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      /*List<String> newThumbnailsForProgressState1 =
          await fetchBookshelfThumbnailsByState(1);
      List<String> newThumbnailsForProgressState2 =
          await fetchBookshelfThumbnailsByState(2);

      setState(() {
        thumbnailsForProgressState1 = newThumbnailsForProgressState1;
        thumbnailsForProgressState2 = newThumbnailsForProgressState2;
      });

      print(thumbnailsForProgressState1);
      print(thumbnailsForProgressState2);*/
      await Provider.of<BookShelfProvider>(context, listen: false).fetchData();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff5f7e9),
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: ImageData(IconsPath.add, isSvg: true, width: 20),
            onPressed: () {
              Get.to(SearchBook());
            },
          ),
          /*actions: [
            IconButton(
              padding: EdgeInsets.only(right: 21),
              icon: isEditMode
                  ? ImageData(IconsPath.check, isSvg: true, width: 20) //색상 변경하기
                  : ImageData(IconsPath.trash_can, isSvg: true, width: 20),
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
                });
                if (!isEditMode) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteDialog();
                    },
                  );
                }
              },
            ),
          ],*/
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/green_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                width: size.width,
                height: size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Consumer<BookShelfProvider>(
                        builder: (context, bookShelfProvider, child) {
                          return State_BookShelfWidget(
                            title: '읽고 있는 책',
                            thumbnailList:
                                bookShelfProvider.thumbnailsForProgressState1,
                          );
                        },
                      ),
                      Consumer<BookShelfProvider>(
                        builder: (context, bookShelfProvider, child) {
                          return State_BookShelfWidget(
                            title: '완독한 책',
                            thumbnailList:
                                bookShelfProvider.thumbnailsForProgressState2,
                          );
                        },
                      ),

                      /*BookShelfWidget(
                        title: '완독한 책',
                        books: recentBooks,
                        isEditMode: isEditMode,
                      ),*/
                      SizedBox(height: 20),
                      BookShelfWidget(
                        title: 'My Favorite',
                        books: finishedBooks,
                        isEditMode: isEditMode,
                      ),
                      /*
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            CarouselSlider(
                              items: shelfSliders,
                              carouselController: _controller,
                              options: CarouselOptions(
                                  viewportFraction: 0.5,
                                  height: size.height * 0.7,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  aspectRatio: 1.0, //0.75,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.zoom,
                                  enlargeFactor: 0.5,
                                  scrollDirection: Axis.vertical,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                            ),
                            //const Spacer(), //izedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  shelfSliders.asMap().entries.map((entry) {
                                return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 15.0,
                                      height: 9.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _current == entry.key
                                              ? Color(0xff969696)
                                              : Color(0xffD9D9D9)),
                                    ));
                              }).toList(),
                            ),
                          
                          */
                    ]))));
  }
}
