import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/components/image_data.dart';
import 'package:reafy_front/src/components/delete_book.dart';
import 'package:reafy_front/src/components/modify_book.dart';
import 'package:reafy_front/src/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({required this.book});

  Widget _book_img() {
    return Container(
        //alignment: Alignment.center,
        width: 200,
        height: 285,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 4.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            book.coverImageUrl,
            fit: BoxFit.fitWidth,
          ),
        ));
  }

  Widget _leaf_img() {
    return Container(
      width: 332.355,
      height: 181.455,
      child: ImageData(IconsPath.book_leaves),
    );
  }

  Widget _hill_img() {
    return Container(
      width: 400, //389
      height: 90, //86.641
      child: ImageData(IconsPath.hill),
    );
  }

  Widget _poobao_img() {
    return Container(
      width: 110.551,
      height: 125.268,
      child: ImageData(IconsPath.character2),
    );
  }

  /*Widget _poobao_shadow() {
    return Container(
      width: 74,
      height: 15,
      child: ImageData(IconsPath.poobao_shadow, isSvg: true),
    );
  }*/

  Widget _book_info() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${book.title}',
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xff333333),
            ),
          ), // title - 변경
          SizedBox(height: 11),
          Row(
            children: [
              Text(
                book.author!.length > 30
                    ? "저자\n" // 최대 20자로 제한
                    : "저자",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 5),
              Text(
                book.author!.length > 30
                    ? '${book.author!.substring(0, 32)}\n${book.author!.substring(
                        31,
                      )}' // 최대 20자로 제한
                    : '${book.author!}',
                overflow: TextOverflow.clip, // 길이 초과 시 '...'로 표시

                //'${book.author}',
                //overflow: TextOverflow.,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ), // 변경
              //ImageData(IconsPath.line, isSvg: true, width: 12),
              /*
              Text(
                "옮김",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(width: 5),
              Text(
                "김욱동",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),*/ // 변경
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                "출판사",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 5),
              Text(
                "세계문학전집",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ), // 변경
            ],
          ),
          //SizedBox(height: 16),
          /*Container(
            //padding: EdgeInsets.only(right: 26.0),
            child: Text(
              "노벨 문학상, 퓰리처상 수상 작가, 20세기 미국 문학을 개척한 작가 어니스트 헤밍웨이의 대표작. 미국 현대 문학의 개척자라 불리는 헤밍웨이는 제1차 세계대전 후 삶의 좌표를 잃어버린 '길 잃은 세대'를 대표하는 작가이다. '민음사 세계문학전집' 278권으로 출간된 <노인과 바다>는 헤밍웨이의 마지막 소설로, 작가 고유의 소설 수법과 실존 철학이 짧은 분량 안에 집약되어 있다. 멕시코 만류에서 홀로 고기잡이를 하는 노인 산티아고는 벌써 84일째 아무것도 잡지 못했다. 같은 마을에 사는 소년 마놀린은 평소 산티아고를 좋아해 그의 일손을 돕곤 했는데, 노인의 운이 다했다며 승선을 만류하는 부모 때문에 이번에는 그와 함께 배를 타지 못한다.",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xff515151),
                height: 1.8,
              ),
              textAlign: TextAlign.justify,
            ), 
          ),*/
        ],
      ),
    );
  }

  Widget _progress() {
    return Container(
      padding: EdgeInsets.only(left: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "진행 정도",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(width: 266.0),
              Text(
                "70%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333),
                ),
              ), //변경
            ],
          ),
          Container(
            //나중엔 벡터 단위로 받아와서 조건 따라 색 변경해야 할듯
            width: 344,
            height: 46,
            child: ImageData(IconsPath.bamboo_bar),
          ),
        ],
      ),
    );
  }

  Widget _memo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "메모",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xff333333),
          ),
        ),
        SizedBox(height: 11),
        Container(
          width: 343,
          height: 114,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFBFBFB),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 14.0),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 7, right: 4),
                    width: 64,
                    height: 64,
                    child: ImageData(IconsPath.memo_ex),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    width: 258,
                    child: Text(
                      "정당의 목적이나 활동이 민주적 기본질서에 위배될 때에는 정부는 헌법재판소에 그 해산을 제소할 수 있고, 정당은 헌법재판소의 심판에 의하여 해산된다. 대통령이 임시회의 집회를 요구할 때에는 기간과 집회요구의 이유를 명시하여야 한다.",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                        height: 1.55556,
                      ),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  SizedBox(width: 6.0),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    width: 46,
                    height: 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffFFECA6),
                    ),
                    child: Center(
                      child: Text(
                        "#경영",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff666666),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    width: 46,
                    height: 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffFFECA6),
                    ),
                    child: Center(
                      child: Text(
                        "#경영",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff666666),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "23.12.03",
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffb3b3b3),
                    ),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    "02:04",
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffb3b3b3),
                    ),
                  ),
                  SizedBox(width: 12.0),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _add_memo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddMemoBottomSheet(context);
      },
      child: Container(
        width: 343,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffB3B3B3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ImageData(
            IconsPath.add_memo,
            isSvg: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 24,
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff63B865)),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(left: 16),
            iconSize: 44,
            icon: ImageData(IconsPath.pencil_green,
                isSvg: true, width: 44, height: 44),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ModifyDialog(); // 수정된 부분
                },
              );
            },
          ),
          IconButton(
            iconSize: 44,
            padding: EdgeInsets.only(right: 16),
            icon: ImageData(IconsPath.trash_can,
                isSvg: true, width: 44, height: 44),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteDialog(); // 수정된 부분
                },
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true, //appbar, body 겹치기
      body: Container(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: 400, //442
                  color: Color(0xfffff7da),
                ),
                Positioned(
                  top: 309.36,
                  child: _hill_img(),
                ),
                Positioned(
                  top: 116,
                  left: 28,
                  child: _leaf_img(),
                ),
                Positioned(
                  top: 95, //84
                  left: 82,
                  child: _book_img(),
                ),
                Positioned(
                  top: 258,
                  left: 232,
                  child: _poobao_img(),
                ),
                /*Positioned(
                  top: 366,
                  left: 249,
                  child: _poobao_shadow(),
                ),*/ //블러 적용 안됨
              ],
            ),
            SizedBox(height: 27.0),
            _book_info(),
            SizedBox(height: 27.0),
            _progress(),
            SizedBox(height: 21.0),
            _memo(),
            SizedBox(height: 9.0),
            _add_memo(context),
            SizedBox(height: 17.0),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 23),
                child: Text(
                  "도서 DB 제공: 알라딘",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffb3b3b3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAddMemoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 24),
        color: Color(0xffffffff),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 42),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_date,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 3.67),
                Text(
                  "생성일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 14),
                Text(
                  "2023년 12월 3일",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
                Text(
                  "02:04",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                  ),
                ),
              ],
            ),
            SizedBox(height: 9.0),
            Row(
              children: [
                Container(
                  width: 13.333,
                  height: 13.333,
                  child: ImageData(
                    IconsPath.memo_tag,
                    isSvg: true,
                  ),
                ),
                SizedBox(width: 4.89),
                Text(
                  "태그",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFFECA6),
                  ),
                  child: Center(
                    child: Text(
                      "#경영",
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  width: 46,
                  height: 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xffb3b3b3), width: 0.8)),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                    child: ImageData(
                      IconsPath.add_tag,
                      isSvg: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26.56),
            Container(
              width: 343,
              height: 179,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xfffbfbfb),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    width: 317,
                    height: 128,
                    child: TextField(
                      maxLength: 400,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '메모를 입력해 주세요.',
                        hintStyle: TextStyle(
                          color: Color(0xffb3b3b3),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w500,
                      ),
                      buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) {
                        return Text(
                          '$currentLength/$maxLength자',
                          style: TextStyle(
                            color: Color(0xffb3b3b3),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: 14,
                        height: 14,
                        child: ImageData(IconsPath.memo_pic, isSvg: true)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Navigator.pop(context); /
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color(0xFFFFD747),
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 5,
                  fixedSize: Size(343, 38)),
              child: Text(
                '게시하기',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
