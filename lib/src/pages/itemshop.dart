import 'package:flutter/material.dart';
import 'package:reafy_front/src/app.dart';
import 'package:reafy_front/src/components/done.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/purchase_dialog.dart';
import 'package:reafy_front/src/components/poobao_home.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/items/bookshelf_item.dart';
import 'package:reafy_front/src/components/items/rug.dart';
import 'package:reafy_front/src/components/items/otheritems.dart';
import 'package:reafy_front/src/components/items/clock.dart';
import 'package:reafy_front/src/components/items/window.dart';
import 'package:reafy_front/src/controller/bottom_nav_controller.dart';
import 'package:reafy_front/src/pages/home.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';

class ItemShop extends StatefulWidget {
  const ItemShop({super.key});
  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  late List<Color> buttonColors;
  late List<FontWeight> buttonWeight;
  late int selectedIndex;

  void initState() {
    super.initState(); // 초기값 설정
    buttonColors = List.filled(5, Color(0xff808080));
    selectedIndex = 0;
    buttonColors[selectedIndex] = Color(0xff63d865);

    buttonWeight = List.filled(5, FontWeight.w400);
    buttonWeight[selectedIndex] = FontWeight.w700;
  }

  void handleButtonPress(int index) {
    setState(() {
      for (int i = 0; i < buttonColors.length; i++) {
        if (i == index) {
          buttonColors[i] = Color(0xff63d865);
          buttonWeight[i] = FontWeight.w700;
        } else {
          buttonColors[i] = Color(0xff808080);
          buttonWeight[i] = FontWeight.w400;
        }
        selectedIndex = index;
      }
    });
  }

  int selectedCategory = 0;

  Widget getSelectedWidget() {
    switch (selectedCategory) {
      case 0:
        return ItemBookshelf();
      case 1:
        return ItemRug();
      case 2:
        return ItemWindow();
      case 3:
        return ItemClock();
      case 4:
        return ItemOthers();
      default:
        return Container(); // 선택된 버튼이 없을 경우 아무것도 표시하지 않음
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemPlacementProvider =
        Provider.of<ItemPlacementProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff333333)),
          onPressed: () {
            Provider.of<ItemPlacementProvider>(context, listen: false)
                .restoreInitialValues();

            Get.back();
          },
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "대나무가 ",
                style: TextStyle(
                    color: Color(0xffff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "42개 ",
                style: TextStyle(
                    color: Color(0xffff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                "남았어요!",
                style: TextStyle(
                    color: Color(0xffff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            icon:
                ImageData(IconsPath.check, isSvg: true, width: 44, height: 44),
            onPressed: () {
              itemPlacementProvider.updateInitialValues(
                itemPlacementProvider.bookshelfImagePath,
                itemPlacementProvider.selectedBookshelfIndex,
                itemPlacementProvider.clockImagePath,
                itemPlacementProvider.selectedClockIndex,
                itemPlacementProvider.othersImagePath,
                itemPlacementProvider.selectedOthersIndex,
                itemPlacementProvider.rugImagePath,
                itemPlacementProvider.selectedRugIndex,
                itemPlacementProvider.windowImagePath,
                itemPlacementProvider.selectedWindowIndex,
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DoneDialog(onDone: () {
                    BottomNavController.to.goToHome();
                    Navigator.pop(context);
                    ; // Navigate to Home
                  });
                  //return DoneDialog();
                },
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(children: [
            SizedBox(height: 20),
            Consumer<ItemPlacementProvider>(
                builder: (context, itemPlacementProvider, child) {
              return Container(
                width: 281.17,
                height: 241,
                //decoration: BoxDecoration(color: Color(0xffd9d9d9)),
                child: Stack(children: [
                  Positioned(
                    top: 64.89,
                    left: 84.98,
                    child: Container(
                      width: 114.32,
                      height: 160.666,
                      child: ImageData(IconsPath.character),
                    ),
                  ),
                  Positioned(
                    top: 21.63,
                    child: Container(
                        //bookshelf
                        width: 77.243,
                        height: 177.66,
                        child: ImageData(
                            itemPlacementProvider.bookshelfImagePath)),
                  ),
                  Positioned(
                    //clock
                    left: 117.42,
                    child: Container(
                        width: 49.436,
                        height: 49.436,
                        child: ImageData(itemPlacementProvider.clockImagePath)),
                  ),
                  Positioned(
                    left: 203.93,
                    top: 26.26,
                    child: Container(
                      //window
                      width: 77.243,
                      height: 77.243,
                      child: ImageData(itemPlacementProvider.windowImagePath),
                    ),
                  ),
                  Positioned(
                    left: 203.93,
                    top: 114.32,
                    child: Container(
                      //others
                      width: 69.519,
                      height: 84.968,
                      child: ImageData(itemPlacementProvider.othersImagePath),
                    ),
                  ),
                  Positioned(
                    top: 213.19,
                    left: 70.29,
                    child: Container(
                      //rug
                      width: 143.637,
                      height: 27.808,
                      child: ImageData(itemPlacementProvider.rugImagePath),
                    ),
                  ),
                ]),
              );
            }),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              height: 1.0,
              color: Color(0xffd9d9d9),
            ),
            Container(
              width: 390,
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(width: 26.0),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        handleButtonPress(0);
                        setState(() {
                          selectedCategory = 0;
                        });
                      },
                      child: Text(
                        '책장',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: buttonWeight[0],
                          color: buttonColors[0],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        handleButtonPress(1);
                        setState(() {
                          selectedCategory = 1;
                        });
                      },
                      child: Text(
                        '러그',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: buttonWeight[1],
                          color: buttonColors[1],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        handleButtonPress(2);
                        setState(() {
                          selectedCategory = 2;
                        });
                      },
                      child: Text(
                        '창문',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: buttonWeight[2],
                          color: buttonColors[2],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        handleButtonPress(3);
                        setState(() {
                          selectedCategory = 3;
                        });
                      },
                      child: Text(
                        '시계',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: buttonWeight[3],
                          color: buttonColors[3],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        handleButtonPress(4);
                        setState(() {
                          selectedCategory = 4;
                        });
                      },
                      child: Text(
                        '소품',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: buttonWeight[4],
                          color: buttonColors[4],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  //SizedBox(width: 26.0),
                ],
              ),
            ),
            getSelectedWidget(),
          ])),
    );
  }
}
