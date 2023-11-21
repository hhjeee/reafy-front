import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:provider/provider.dart';
import 'package:reafy_front/src/components/poobao_home.dart';

class ItemData {
  final String imagePath;
  final String text;

  ItemData({required this.imagePath, required this.text});
}

List<ItemData> itemDataList = [
  ItemData(imagePath: 'assets/images/nothing.png', text: '선택 안함'),
  ItemData(imagePath: 'assets/images/clock1.png', text: '시계1'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계2'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계3'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계4'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계5'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계6'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계7'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계8'),
  ItemData(imagePath: 'assets/images/nothing.png', text: '시계9'),
  // ...
];

class ItemClock extends StatefulWidget {
  @override
  _ItemClockState createState() => _ItemClockState();
}

class _ItemClockState extends State<ItemClock> {
  int selectedGridIndex = 0;
  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    final poobaoHome = Provider.of<PoobaoHome>(context, listen: true);
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
              childAspectRatio: 0.8,
            ),
            itemCount: itemDataList.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedGridIndex == index;
              ItemData itemIndex = itemDataList[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedGridIndex = index;
                    selectedImagePath = itemIndex.imagePath;

                    poobaoHome.updateClockImagePath(itemIndex.imagePath);
                    poobaoHome.updateSelectedImagePath(itemIndex.imagePath);
                    poobaoHome.updateSelectedItemName(itemIndex.text);
                  });
                },
                child: GridItem(
                  index,
                  itemIndex,
                  isSelected,
                  selectedImagePath,
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
  String selectedImagePath,
) {
  bool isButtonEnabled = index < 8; //사용자가 가지고 있는 아이템일 경우

  return Flexible(
    child: Column(
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
                    : Color(0xffd9d9d9),
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
                    : Border.all(
                        color: Color(0xffffffff),
                        width: 9.5,
                      ),
              ),
              child: itemIndex.imagePath.isNotEmpty
                  ? Container(
                      width: 40,
                      height: 40,
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
                child: ImageData(IconsPath.lock),
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
          style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
