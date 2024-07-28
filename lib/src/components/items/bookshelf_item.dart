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
  //대나무 수 추가
  //bookshelf - 0~19
  ItemData(
      itemId: 0,
      imagePath: 'assets/images/nothing.png',
      text: '선택 안함',
      price: 0),
  ItemData(
      itemId: 1,
      imagePath: 'assets/images/items/bookshelf1.png',
      text: '심플 책장',
      price: 20),
  ItemData(
      itemId: 2,
      imagePath: 'assets/images/items/bookshelf2.png',
      text: '크리스마스 \n책장',
      price: 40),
  ItemData(
      itemId: 3,
      imagePath: 'assets/images/items/bookshelf3.png',
      text: '당근 책장',
      price: 60),
  ItemData(
      itemId: 4,
      imagePath: 'assets/images/items/bookshelf4.png',
      text: '무지개 책장',
      price: 80),
  ItemData(
      itemId: 5,
      imagePath: 'assets/images/items/bookshelf5.png',
      text: '아이스크림 \n책장',
      price: 100),
  ItemData(
      itemId: 6,
      imagePath: 'assets/images/items/bookshelf6.png',
      text: '나무 책장',
      price: 150),
  ItemData(
      itemId: 7,
      imagePath: 'assets/images/items/bookshelf7.png',
      text: '판다 책장',
      price: 200),
];

class ItemBookshelf extends StatefulWidget {
  @override
  _ItemBookshelfState createState() => _ItemBookshelfState();
}

class _ItemBookshelfState extends State<ItemBookshelf> {
  int selectedGridIndex = 0;
  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();

    Provider.of<ItemProvider>(context, listen: false).fetchUserItems();
    // 이전에 선택한 값으로 초기화
    selectedGridIndex =
        Provider.of<ItemPlacementProvider>(context, listen: false)
            .getSelectedBookshelfIndex();
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
                      itemPlacementProvider.updateBookshelfData(
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
                      // 구매가 성공하면 선택 상태 초기화
                      if (value == true) {
                        resetSelection();
                      }
                    });
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
                ? Container(
                    width: 40,
                    height: 60,
                    child: ImageData(itemIndex.imagePath),
                  )
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
