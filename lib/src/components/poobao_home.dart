import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/image_data.dart';

class PoobaoHome extends ChangeNotifier {
  double width;
  double height;
  String bookshelf_imagePath;
  String clock_imagePath;
  String window_imagePath;
  String others_imagePath;
  String rug_imagePath;
  String selectedImagePath;
  String selectedItemName;

  /*PoobaoHome({
    required this.width,
    required this.height,
    required this.bookshelf_imagePath,
  });*/
  PoobaoHome({
    //default 값 설정
    this.width = 296,
    this.height = 255,
    this.bookshelf_imagePath = "assets/images/nothing.png",
    this.clock_imagePath = "assets/images/nothing.png",
    this.window_imagePath = "assets/images/nothing.png",
    this.others_imagePath = "assets/images/nothing.png",
    this.rug_imagePath = "assets/images/nothing.png",
    this.selectedImagePath = "assets/images/nothing.png",
    this.selectedItemName = "아이템",
  });

  void updateBookshelfImagePath(String newPath) {
    bookshelf_imagePath = newPath;
    notifyListeners(); // 변경을 Consumer에 알림
  }

  void updateClockImagePath(String newPath) {
    clock_imagePath = newPath;
    notifyListeners();
  }

  void updateWindowImagePath(String newPath) {
    window_imagePath = newPath;
    notifyListeners();
  }

  void updateOthersImagePath(String newPath) {
    others_imagePath = newPath;
    notifyListeners();
  }

  void updateRugImagePath(String newPath) {
    rug_imagePath = newPath;
    notifyListeners();
  }

  void updateSelectedImagePath(String imagePath) {
    selectedImagePath = imagePath;
    notifyListeners();
  }

  void updateSelectedItemName(String imageName) {
    selectedItemName = imageName;
    notifyListeners();
  }
  /*void updateProps(
      //{required double width,
      //required double height,}
      ) {
    this.width = width;
    this.height = height;
    this.bookshelf_imagePath = bookshelf_imagePath;
    this.clock_imagePath = clock_imagePath;
    this.window_imagePath = window_imagePath;
    this.others_imagePath = others_imagePath;
    // this.rug_imagePath = rug_imagePath;

    // 상태가 변경되었음을 리스너에게 알립니다.
    notifyListeners();
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: 31,
            child: Container(
                //bookshelf
                width: 110,
                height: 240,
                //decoration: BoxDecoration(color: Colors.orange),
                child: ImageData(bookshelf_imagePath)),
          ),
          Positioned(
            //clock
            left: 160,
            child: Container(
                width: 70,
                height: 70,
                //decoration: BoxDecoration(color: Colors.yellow),
                child: ImageData(clock_imagePath)),
          ),
          Positioned(
            left: 274,
            top: 18,
            child: Container(
              //window
              width: 110,
              height: 110,
              //decoration: BoxDecoration(color: Colors.blue),
              child: ImageData(window_imagePath),
            ),
          ),
          Positioned(
            left: 274,
            top: 151,
            child: Container(
              //others
              width: 100,
              height: 120,
              //decoration: BoxDecoration(color: Colors.pink),
              child: ImageData(others_imagePath),
            ),
          ),
          Positioned(
            top: 279,
            left: 95,
            child: Container(
              //rug
              width: 200,
              height: 40,
              //decoration: BoxDecoration(color: Colors.red),
              child: ImageData(rug_imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
