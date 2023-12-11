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
import 'package:reafy_front/src/components/favorite_BookList.dart';

class BookShelf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookShelfState();
  }
}

class _BookShelfState extends State<BookShelf> {
  bool isEditMode = false;

  List<String> thumbnailsForProgressState1 = [];
  List<String> thumbnailsForProgressState2 = [];
  List<String> thumbnailsForIsFavorite = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
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
            iconSize: 44,
            padding: EdgeInsets.all(0),
            icon: ImageData(IconsPath.add, isSvg: true),
            onPressed: () {
              Get.to(SearchBook());
            },
          ),

          /*actions: [
            IconButton(
              iconSize: 44,
              padding: EdgeInsets.only(right: 21),
              icon: isEditMode
                  ? ImageData(IconsPath.check, isSvg: true) //색상 변경하기
                  : ImageData(IconsPath.trash_can, isSvg: true),
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
                      SizedBox(height: 20),
                      Consumer<BookShelfProvider>(
                        builder: (context, bookShelfProvider, child) {
                          return isFavorite_BookShelfWidget(
                            title: 'My Favorite',
                            thumbnailList:
                                bookShelfProvider.thumbnailsForIsFavorite,
                          );
                        },
                      ),
                    ]))));
  }
}
