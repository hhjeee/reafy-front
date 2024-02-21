import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/purchase_dialog.dart';
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
  //others 40~59
  ItemData(
      itemId: 40,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      price: 0),
  ItemData(
      itemId: 41,
      imagePath: 'assets/images/items/item_simple.png',
      text: '심플 소품',
      price: 5),
  ItemData(
      itemId: 42,
      imagePath: 'assets/images/items/item_tree.png',
      text: '트리',
      price: 10),
  ItemData(
      itemId: 43,
      imagePath: 'assets/images/items/item_orange.png',
      text: '오렌지 테이블',
      price: 15),
  ItemData(
      itemId: 44,
      imagePath: 'assets/images/items/item_light.png',
      text: '달 전구',
      price: 20),
  ItemData(
      itemId: 45,
      imagePath: 'assets/images/items/item_bear.png',
      text: '곰인형',
      price: 25),
  ItemData(
      itemId: 46,
      imagePath: 'assets/images/items/item_flower.png',
      text: '꽃 의자',
      price: 30),
  ItemData(
      itemId: 47,
      imagePath: 'assets/images/items/item_bamboo.png',
      text: '대나무 화분',
      price: 50),
];

class ItemOthers extends StatefulWidget {
  @override
  _ItemOthersState createState() => _ItemOthersState();
}

class _ItemOthersState extends State<ItemOthers> {
  int selectedGridIndex = 0;
  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();

    // 이전에 선택한 값으로 초기화
    selectedGridIndex =
        Provider.of<ItemPlacementProvider>(context, listen: false)
            .getSelectedOthersIndex();
  }

  @override
  Widget build(BuildContext context) {
    final itemPlacementProvider =
        Provider.of<ItemPlacementProvider>(context, listen: false);

    return Container(
      child: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //그리드 열 수
              crossAxisSpacing: 14.0, //가로 간격
              mainAxisSpacing: 16.0, // 세로 간격
              childAspectRatio: 0.6,
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
                      itemPlacementProvider.updateOthersData(
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
                    );
                  }
                },
                child: GridItem(
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
  int index,
  ItemData itemIndex,
  bool isSelected,
  String selectedImagePath, {
  required bool isButtonEnabled,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 79,
            height: 79,
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
              width: 79,
              height: 79,
              decoration: BoxDecoration(
                color: Color(0xff000000).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: ImageData(IconsPath.lock)),
            ),
          if (index == 0)
            Container(
              width: 79,
              height: 79,
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
