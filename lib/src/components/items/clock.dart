import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/dialog/purchase_dialog.dart';
import 'package:reafy_front/src/provider/item_provider.dart';
import 'package:reafy_front/src/provider/item_placement_provider.dart';

class ItemData {
  final int itemId;
  final String imagePath;
  final String text;
  final int price;

  ItemData(
      {required this.itemId,
      required this.imagePath,
      required this.text,
      required this.price});
}

List<ItemData> itemDataList = [
  //clock 20 ~ 39
  ItemData(
      itemId: 20,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      price: 0),
  ItemData(
      itemId: 21,
      imagePath: 'assets/images/items/clock_simple.png',
      text: '심플 시계',
      price: 5),
  ItemData(
      itemId: 22,
      imagePath: 'assets/images/items/clock_socks.png',
      text: '양말 시계',
      price: 10),
  ItemData(
      itemId: 23,
      imagePath: 'assets/images/items/clock_apple.png',
      text: '사과 시계',
      price: 15),
  ItemData(
      itemId: 24,
      imagePath: 'assets/images/items/clock_star.png',
      text: '별 시계',
      price: 20),
  ItemData(
      itemId: 25,
      imagePath: 'assets/images/items/clock_button.png',
      text: '단추 시계',
      price: 25),
  ItemData(
      itemId: 26,
      imagePath: 'assets/images/items/clock_clover.png',
      text: '네잎클로버 \n시계',
      price: 30),
  ItemData(
      itemId: 27,
      imagePath: 'assets/images/items/clock_panda.png',
      text: '판다 시계',
      price: 50),
];

class ItemClock extends StatefulWidget {
  @override
  _ItemClockState createState() => _ItemClockState();
}

class _ItemClockState extends State<ItemClock> {
  int selectedGridIndex = 0;
  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();

    // 이전에 선택한 값으로 초기화
    selectedGridIndex =
        Provider.of<ItemPlacementProvider>(context, listen: false)
            .getSelectedClockIndex();
  }

  void resetSelection() {
    setState(() {
      selectedGridIndex = 0;
      selectedImagePath = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemPlacementProvider =
        Provider.of<ItemPlacementProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: size.width > 700 ? size.height * 0.55 : size.height * 0.45,
          padding: EdgeInsets.only(top: 25, left: 16, right: 16),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //그리드 열 수
              crossAxisSpacing: 14.0, //가로 간격
              mainAxisSpacing: 16.0, // 세로 간격
              childAspectRatio: size.width > 700 ? 0.7 : 0.65,
            ),
            itemCount: itemDataList.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedGridIndex == index;
              ItemData itemIndex = itemDataList[index];
              bool isButtonEnabled = Provider.of<ItemProvider>(context)
                      .ownedItemIds
                      .contains(itemIndex.itemId) ||
                  index == 0;

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedGridIndex = index;
                    selectedImagePath = itemIndex.imagePath;

                    if (isButtonEnabled) {
                      itemPlacementProvider.updateClockData(
                          itemIndex.itemId, index, itemIndex.imagePath);
                    }
                  });
                  if (!isButtonEnabled) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PurchaseDialog(
                          itemId: itemIndex.itemId,
                          itemName: itemIndex.text,
                          itemImagePath: itemIndex.imagePath,
                          itemPrice: itemIndex.price,
                        );
                      },
                    ).then((value) {
                      if (value == true) {
                        resetSelection();
                      }
                    });
                  }
                },
                child: GridItem(
                  context,
                  index,
                  itemIndex,
                  isSelected,
                  selectedImagePath,
                  isButtonEnabled: isButtonEnabled,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget GridItem(
  BuildContext context,
  int index,
  ItemData itemIndex,
  bool isSelected,
  String selectedImagePath, {
  required bool isButtonEnabled,
}) {
  final size = MediaQuery.of(context).size;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: (size.width - 50 - 42) / 4,
            height: (size.width - 50 - 42) / 4,
            decoration: BoxDecoration(
                color: isSelected && isButtonEnabled
                    ? Color(0xfffffd747).withOpacity(0.1)
                    : Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
                border: isSelected && isButtonEnabled
                    ? Border.all(color: Color(0xffffd747), width: 2)
                    : Border.all(color: Color(0xffffffff), width: 2)),
            child: itemIndex.imagePath.isNotEmpty
                ? Center(
                    child: Container(
                    width: 60,
                    height: 60,
                    child: ImageData(itemIndex.imagePath),
                  ))
                : null,
          ),
          if (!isButtonEnabled)
            Container(
              width: (size.width - 50 - 42) / 4,
              height: (size.width - 50 - 42) / 4,
              decoration: BoxDecoration(
                color: Color(0xff000000).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: ImageData(IconsPath.lock)),
            ),
          if (index == 0)
            Container(
              width: (size.width - 50 - 42) / 4,
              height: (size.width - 50 - 42) / 4,
              child: ImageData(IconsPath.select_nothing),
            ),
        ],
      ),
      SizedBox(height: 6.0),
      Text(
        itemIndex.text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color(0xff333333),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}
