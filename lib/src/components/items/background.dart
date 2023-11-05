import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

class ItemData {
  final String imagePath;
  final String text;

  ItemData({required this.imagePath, required this.text});
}

List<ItemData> itemDataList = [
  ItemData(imagePath: '', text: '선택 안함'),
  ItemData(imagePath: IconsPath.sofa1, text: '보라색 소파'),
  ItemData(imagePath: IconsPath.sofa2, text: '삼등분 소파'),
  ItemData(imagePath: '', text: '벽지2'),
  ItemData(imagePath: '', text: '벽지3'),
  ItemData(imagePath: '', text: '벽지4'),
  ItemData(imagePath: '', text: '벽지5'),
  ItemData(imagePath: '', text: '벽지6'),
  ItemData(imagePath: '', text: '벽지7'),
  ItemData(imagePath: '', text: '벽지8'),
  ItemData(imagePath: '', text: '벽지9'),
  ItemData(imagePath: '', text: '벽지10'),
  ItemData(imagePath: '', text: '벽지11'),
  // ...
];

class ItemBackGround extends StatefulWidget {
  @override
  _ItemBackGroundState createState() => _ItemBackGroundState();
}

class _ItemBackGroundState extends State<ItemBackGround> {
  int selectedGridIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            itemCount: 13, //나중엔 저장된 이미지배열의 length값으로
            itemBuilder: (context, index) {
              bool isSelected = selectedGridIndex == index;
              ItemData itemIndex = itemDataList[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedGridIndex = index;
                  });
                },
                child: GridItem(itemIndex, isSelected),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget GridItem(ItemData itemIndex, bool isSelected) {
  return Flexible(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 79,
          height: 79,
          decoration: BoxDecoration(
            color: isSelected
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
            border: isSelected
                ? Border.all(color: Color(0xffffd747), width: 2)
                : null,
          ),
          /*child: itemIndex.imagePath.isNotEmpty
              ? Container(
                  width: 40,
                  height: 40,
                  child: ImageData(itemIndex.imagePath),
                )
              : SizedBox(),*/
        ),
        SizedBox(height: 4.0),
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
