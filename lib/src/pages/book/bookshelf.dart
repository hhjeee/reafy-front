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

Widget _header() {
  return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              Get.to(Addbook()); // '/itemshop' 페이지로 이동
            },
            child: ImageData(
              IconsPath.add,
              isSvg: true,
              width: 20,
            )),
        GestureDetector(
            onTap: () {
              //////Get.to(Addbook()); // '/itemshop' 페이지로 이동
            },
            child: ImageData(
              IconsPath.delete,
              isSvg: true,
              width: 20,
            )),
      ]));
}

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
    return Container(
        decoration: BoxDecoration(
            color: Color(0xffFFF7DA),
            gradient: LinearGradient(
                colors: [Color(0xffFFF7DA), Color(0xffFCFCFA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _header(),
                  const Spacer(),
                  Container(
                      child: Column(children: [
                    Text('읽는 중',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w800,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: shelfSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 0.75,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          enlargeFactor: 0.4,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: shelfSliders.asMap().entries.map((entry) {
                        return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
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
                    //const Spacer(),
                  ])),
                ])));
  }
}
