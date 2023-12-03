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
              color: Color(0xff000000),
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
                  color: Color(0xff000000),
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
                  color: Color(0xff000000),
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
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(width: 5),
              Text(
                "세계문학전집",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ), // 변경
            ],
          ),
          SizedBox(height: 16),
          Container(
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
            ), //변경
          ),
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
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(width: 266.0),
              Text(
                "70%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff63B865)),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back()을 사용합니다.
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            icon: ImageData(IconsPath.pencil_green, isSvg: true, width: 20),
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
            padding: EdgeInsets.only(right: 21),
            icon: ImageData(IconsPath.trash_can, isSvg: true, width: 20),
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
            SizedBox(height: 40.0), //임의값
            _progress(),
          ],
        ),
      ),
    );
  }
}
