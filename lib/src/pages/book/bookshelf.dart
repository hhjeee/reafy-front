import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/shelfwidget.dart';
import 'package:reafy_front/src/pages/book/addbook.dart';

final List<String> bookList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> shelfSliders = bookList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                child: Stack(
              children: <Widget>[
                BookShelfWidget(),
              ],
            )),
          ),
        ))
    .toList();

class BookShelf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookShelfState();
  }
}

class _BookShelfState extends State<BookShelf> {
  int _current = 1;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFFCF3),
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: ImageData(IconsPath.add, isSvg: true, width: 20),
            onPressed: () {
              Get.to(SearchBook());
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 21),
              icon: ImageData(IconsPath.trash_can, isSvg: true, width: 20),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffFFF7DA),
                    gradient: LinearGradient(
                        colors: [Color(0xffFFFCF3), Color(0xffFCFCFA)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                //child: Padding(
                //    padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
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
                          ]))
                    ]))));
  }
}
